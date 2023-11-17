import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uwifi_map_services/data/constants.dart';
import '../classes/plan.dart';

class PlanController with ChangeNotifier {
  List<Plan> _plansList = [];
  List<String> plansCategories = [];
  List<Plan> get plansList => _plansList;
  List<Plan> plansWithPromo = [];
  String _customerType = '';
  String _locationGroup = '';
  String _networkType = '';

  List<Products> promosList = [];
  List<Plan> plansWActivePromo = [];
  List<PromoGroup> promoGroups = [];

  set customerType(customerType) {
    _customerType = customerType;
  }

  String get customerType => _customerType;

  set locationGroup(location) {
    _locationGroup = location;
  }

  String get locationGroup => _locationGroup;

  set networkType(technology) {
    _networkType = technology;
  }

  String get networkType => _networkType;

  PlanController(
      String networkType, String customerType, String locationGroup) {
    // C O N F I G   D E   P L A N E S   E N   F R O N T E N D

    //Carga de planes obtenidos desde el API
    loadPlans(networkType, customerType, locationGroup);

    this.customerType = customerType;
    this.networkType = networkType;
    this.locationGroup = locationGroup;

    notifyListeners();
  }

  int highestPrice(p1, p2) => p2.price - p1.price;

  int lowestPrice(p1, p2) => p1.price - p2.price;

  Future<List<Plan>?> loadPlans(
      String networkType, String customerType, String locationGroup) async {
    try {
      var url = Uri.parse('$env/planbuilder/api');

      final bodyMsg = jsonEncode({
        "action": "products",
        "networkType": networkType,
        "customerType": customerType,
        "locationgroup": locationGroup
      });
      var response = await http.post(url, body: bodyMsg);
      _plansList = json
          .decode(response.body)["result"]
          .map<Plan>(
            (data) => Plan(
              data['id'],
              data['family'],
              data['name'],
              data['featTittle'],
              data['description'],
              data['featDesc'],
              double.parse(data['price']),
              data['family'].contains("gigFastInternet") ||
                      data['family'].contains("bundle")
                  ? data['enabled']
                  : false,
              false,
              data['pwName'] ?? '',
              identifyComingSoonPlan(data['groups'], locationGroup),
              data['associations'] == null
                  ? null
                  : Associations.fromMap(data['associations']),
            ),
          )
          .toList();

      //Obtención de las categorías de los planes obtenidos
      getPlansCategories();

      //Obtención de los planes que cuentan con promoción, así como el listado
      //de todas las promociones encontradas
      getPromosPlansList();

      return _plansList;
    } catch (e) {
      // ignore: avoid_print
      print('Exception on loadPlans(): $e');
    }
    return null;
  }

  getPlansCategories() {
    plansCategories =
        _plansList.map((plan) => plan.planCategory).toSet().toList();
    plansCategories.sort();

    notifyListeners();
  }

  selectPlan(Plan plan) {
    setUnselection(plan);

    _plansList = _plansList
        .map(
          (item) => item.name == plan.name
              ? item.copyWith(
                  isSelected: true,
                )
              : item,
        )
        .toList();

    notifyListeners();
  }

//Función que recorre el listado y cambia el estado a "no seleccionado" de los planes que se encuentren dentro de la misma categoría que el plan actual/recibido
  setUnselection(Plan plan) {
    _plansList = _plansList
        .map(
          (item) => item.planCategory == plan.planCategory
              ? item.copyWith(isSelected: false)
              : item,
        )
        .toList();

    notifyListeners();
  }

  unselectAll() {
    _plansList =
        _plansList.map((plan) => plan.copyWith(isSelected: false)).toList();
    notifyListeners();
  }

  plansActivation(List<String> exceptions, bool planStatus) {
    _plansList = _plansList
        .map(
          (plan) => !(exceptions.contains(plan.planCategory)) &&
                  plan.isComing == false
              ? plan.copyWith(isEnabled: planStatus)
              : plan,
        )
        .toList();

    notifyListeners();
  }

  lowestPlanActivation() {
    _plansList = _plansList
        .map(
          (plan) => plan == getHighestTVPlan()
              ? plan.copyWith(isEnabled: false, isSelected: false)
              : plan,
        )
        .toList();

    notifyListeners();
  }

  getHighestTVPlan() {
    var tvPlans =
        _plansList.where((plan) => plan.planCategory.contains('TV')).toList();
    tvPlans.sort(highestPrice);

    return tvPlans.first;
  }

  getLowestIntPlan() {
    var intPlans = _plansList
        .where((plan) => plan.planCategory.contains('Internet'))
        .toList();
    intPlans.sort(lowestPrice);

    return intPlans.first;
  }

  bool identifyComingSoonPlan(List<dynamic> groups, locationGroup) {
    List<dynamic> comingPlans = [];

    if (!("".contains(locationGroup))) {
      comingPlans = groups.where((g) => g.contains(locationGroup)).toList();
    }

    return comingPlans.isNotEmpty;
  }

  // F U N C I O N E S   P A R A   P R O M O C I O N E S

  getPromosPlansList() {
    //Identificación de los planes que cuentan con promos asociadas
    plansWithPromo =
        (_plansList.where((plan) => plan.associations != null)).toList();

    //Guardado de las promociones de los planes identificados con promos
    for (var plan in plansWithPromo) {
      for (var promo in plan.associations!.pack!.products!) {
        //Identificar si la promo está habilitada para agregarla a la lista
        if (promo.enabled == true && promo.categories!.contains("Promo")) {
          promosList.add(promo);
        }
      }
    }

    //Se identifican los nombres únicos de las promociones
    final promoNames = promosList.map((promo) => promo.name).toSet().toList();

    //Se eliminan las promociones repetidas comparándolo con el listado de nombres únicos
    promosList.retainWhere((x) => promoNames.remove(x.name));

//Se encuentran los id de los grupos encontrados de promociones
    List<String> promoGroupsIds = promosList
        .where((promo) => promo.groups!.isNotEmpty)
        .map((promo) => promo.groups![0].toString())
        .toSet()
        .toList();
    promoGroupsIds.sort();

    //Se guardan las promociones que se encuentran en un mismo grupo:
    for (var promoGroup in promoGroupsIds) {
      PromoGroup temp = PromoGroup(
          promoGroup,
          false,
          parsePromoName(promoGroup),
          promosList
              .where((promo) => promo.groups!.contains(promoGroup))
              .toList()
              .first
              .descriptionPic,
          promosList
              .where((promo) => promo.groups!.contains(promoGroup))
              .toList());

      promoGroups.add(temp);
    }

    for (var promo in promosList) {
      if (promo.groups!.isEmpty) {
        PromoGroup temp = PromoGroup(
            promo.name!,
            false,
            promo.name,
            promosList
                .where((promotion) => promotion.id == promo.id)
                .toList()
                .first
                .descriptionPic,
            promosList.where((promotion) => promotion.id == promo.id).toList());

        promoGroups.add(temp);
      }
    }

    notifyListeners();
  }

  findPromoPlans(Products promo) {
    //Devuelve un listado de los planes que cuentan con la promoción especificada

    return (plansWithPromo
        .where((plan) => plan.associations!.pack!.products!
            .map((product) => product.groups.toString())
            .contains(promo.groups.toString()))
        .toList());
  }

  findPlanWActivePromo(Plan plan) {
    bool planPromoActivated = false;
    //Devuelve si es true o false que el plan se encuentre en la lista de los planes
    //que cuentan con promo activa:

    var activePromos =
        plansWActivePromo.where((item) => item.id == plan.id).toList();

    if (activePromos.isNotEmpty) planPromoActivated = true;

    return planPromoActivated;
  }

  bool isAnyPlanActive() {
    bool planActive = false;

    var activePromos =
        promosList.where((promo) => promo.isActive == true).toList();

    if (activePromos.isNotEmpty) planActive = true;

    return planActive;
  }

///// Funciones para activación de todas las promociones
  promosDeactivation(activePromo) {
    //Se establecen como promos desactivadas aquellas que no concuerden con
    // el grupo de promociones de la promoción recibida
    promosList = promosList
        .map((promo) =>
            promo.groups!.toString() == activePromo.groups.toString()
                ? promo.copyWith(isActive: false)
                : promo)
        .toList();

    notifyListeners();
  }

  promoActivation(Products promo, bool status) {
    //Se desactivan todos los toggles de promociones

    //promosDeactivation(promo);

    //Se cambia el status si el grupo de promociones se habilitaron
    promoGroups = promoGroups
        .map((promoGroup) => promoGroup.promos.contains(promo)
            ? promoGroup.copyWith(isActive: status)
            : promoGroup.copyWith(isActive: false))
        .toList();

    //Se cambia el status de la promoción seleccionada

    promosList = promosList
        .map(
          (item) => item.groups.toString() == promo.groups.toString()
              ? item.copyWith(isActive: status)
              : item.copyWith(isActive: false),
        )
        .toList();

    if (status == true) {
      //Recibiendo como parámetro una promoción activa, se genera un listado con
      //todos los planes que cuenten con dicha promoción.
      plansWActivePromo = findPromoPlans(promo);
    } else {
      plansWActivePromo.clear();
    }

    notifyListeners();
  }

  //Obtención del precio que se despliega en la vista de planes. Si cuenta con una promoción ligada y esta está activada en la lista, el precio desplegado del plan cambia al valor que tendría con la promoción
  //OJO: No cambia el precio del paquete. Sólo cambia el desplegado en la lista de planes.
  double setPromoPrice(double planPrice, Products promo) {
    double planPromoPrice = 0;
    promo.family!.contains("Fees")
        ? planPromoPrice = planPrice + double.parse(promo.price!)
        : planPromoPrice = planPrice - double.parse(promo.price!);
    return planPromoPrice;
  }

  parsePromoName(String name) {
    String parsedName = name;
    if (name.contains("SM")) {
      parsedName = "Social Media Promos";
    }

    return parsedName;
  }
}
