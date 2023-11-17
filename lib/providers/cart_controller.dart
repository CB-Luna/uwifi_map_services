import 'package:flutter/material.dart';
import '../classes/plan.dart';
import '../classes/product.dart';

class Cart with ChangeNotifier {
  bool promoGratefulSwitcher = false;
  bool promoSMSwitcher = false;
  double additionalsTVPrice = 0;
  double additionalsVoice = 0;
  double additionalsVoiceDynamic = 0;
  double totalDevices = 0;
  double bundleDiscount = 0;
  int productsCategoryQty = 0;
  int badgeCounterTotal = 0;
  bool isSelected = false;
  bool isSupportedDevicesVisible = true;
  bool buttonVisible = true;
  bool aciveToogle = false;
  List<Product> products = [];
  List<Product> devices = [];
  List<Product> additionalsDevicesSelected = [];
  List<Product> moviesbundle = [];
  List<Product> moviesBundleSelected = [];
  List<Product> fees = [];
  List<Product> additionals = [];
  List<Product> discounts = [];

  Product? promoTV;
  Product? promoInternet;
  Product? promoTelephone;

  List<Product> packsPremium = [];
  List<Product> packsPremiumSelected = [];
  List<Product> additionalsVideo = [];
  List<Product> additionalsVideoSelected = [];
  List<Product> additionalsRecording = [];
  List<Product> additionalsRecordingSelected = [];
  List<Product> additionalsLine = [];

  int get generalCartCounter {
    var counter = products.length + additionals.length + devices.length;
    return counter;
  }

  double get total {
    var totalprod =
        products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.cost;
    });
    var totaldevices =
        devices.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + (nextProduct.cost * nextProduct.quantity);
    });
    var totalfess = fees.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.cost;
    });

    var totalDiscounts =
        discounts.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.cost;
    });

    var subtotal = totalprod +
        totaldevices +
        totalfess +
        additionalsTVPrice +
        additionalsVoice;

    return subtotal - totalDiscounts;
  }

  bool checkProductOnAdditionals(String idProduct) {
    bool isEmpty = false;
    for (var i = 0; i < additionals.length; i++) {
      if (additionals[i].id == idProduct) {
        isEmpty = true;
      }
    }
    return isEmpty;
  }

  bool isSelectedGigFastTV() {
    bool isSelectedGigFastTV = false;
    for (var i = 0; i < products.length; i++) {
      if (products[i].category == "gigFastTV") {
        isSelectedGigFastTV = true;
      }
    }
    return isSelectedGigFastTV;
  }

  bool isSelectedGigFastVoice() {
    bool isSelectedGigFastVoice = false;
    for (var i = 0; i < products.length; i++) {
      if (products[i].category == "gigFastVoice") {
        isSelectedGigFastVoice = true;
      }
    }
    return isSelectedGigFastVoice;
  }

  void changeMovieBundlesSelected(int index) {
    if (moviesbundle[index].isSelected == true) {
      moviesBundleSelected.remove(moviesbundle[index]);
      additionals.remove(moviesbundle[index]);
      badgeCounterTotal = badgeCounterTotal - 1;

      additionalsTVPrice = additionalsTVPrice - moviesbundle[index].cost;
      moviesbundle[index].isSelected = false;
    } else {
      additionalsTVPrice = additionalsTVPrice + moviesbundle[index].cost;
      moviesbundle[index].isSelected = true;
      moviesBundleSelected.add(moviesbundle[index]);
      additionals.add(moviesbundle[index]);
      badgeCounterTotal = badgeCounterTotal + 1;
    }

    notifyListeners();
  }

  void changeSliderAdditionalLine(double value, int index) {
    if (value >= 1) {
      if (additionals.contains(additionalsLine[index])) {
        additionalsVoiceDynamic =
            additionalsLine[index].quantity * additionalsLine[index].cost;
        additionalsVoice = additionalsVoice - additionalsVoiceDynamic;
        additionalsLine[index].quantity = value.toInt();
        additionalsVoiceDynamic =
            additionalsLine[index].quantity * additionalsLine[index].cost;
        additionalsVoice = additionalsVoice + additionalsVoiceDynamic;
      } else {
        additionalsLine[index].quantity = value.toInt();
        additionalsVoiceDynamic =
            additionalsLine[index].quantity * additionalsLine[index].cost;
        additionalsVoice = additionalsVoice + additionalsVoiceDynamic;
        additionals.add(additionalsLine[index]);
      }
    } else {
      additionalsVoiceDynamic =
          additionalsLine[index].quantity * additionalsLine[index].cost;
      additionalsVoice = additionalsVoice - additionalsVoiceDynamic;
      additionalsLine[index].quantity = value.toInt();
      additionalsVoiceDynamic =
          additionalsLine[index].quantity * additionalsLine[index].cost;
      additionalsVoice = additionalsVoice + additionalsVoiceDynamic;
      additionals.remove(additionalsLine[index]);
    }
    notifyListeners();
  }

  void changeSwitchAdditionalLine(int index, bool switchON) {
    if (switchON) {
      if (additionals.contains(additionalsLine[index])) {
        additionals.remove(additionalsLine[index]);
      }
      additionalsLine[index].quantity = 1;
      additionalsVoiceDynamic =
          additionalsLine[index].quantity * additionalsLine[index].cost;
      additionalsVoice = additionalsVoice + additionalsVoiceDynamic;
      additionals.add(additionalsLine[index]);
    } else {
      additionalsLine[index].quantity = 0;
      additionalsVoiceDynamic = additionalsLine[index].cost;
      additionalsVoice = additionalsVoice - additionalsVoiceDynamic;
      additionals.remove(additionalsLine[index]);
    }
    notifyListeners();
  }

  void changeVisibilitySupportedDevices() {
    isSupportedDevicesVisible = !isSupportedDevicesVisible;
    notifyListeners();
  }

  void addCounterSetTopBox(int index) {
    if (devices[index].quantity >= 1 && devices[index].quantity < 10) {
      devices[index].quantity = devices[index].quantity + 1;
      totalDevices = devices[index].cost * devices[index].quantity;
    }
    notifyListeners();
  }

  void removeCounterSetTopBox(int index) {
    if (devices[index].quantity > 1) {
      devices[index].quantity--;
      totalDevices = devices[index].cost * devices[index].quantity;
    }
    notifyListeners();
  }

  void changeSelectedSuportedDevices(int index) {
    if (devices[index].quantity > 0) {
      devices[index].quantity = 0;
      totalDevices = devices[index].cost * devices[index].quantity;
      devices[index].isSelected = false;
      additionalsDevicesSelected.remove(devices[index]);
      badgeCounterTotal = badgeCounterTotal - 1;
    } else {
      devices[index].quantity = devices[index].quantity + 1;
      totalDevices = devices[index].cost * devices[index].quantity;
      additionalsDevicesSelected.add(devices[index]);
      devices[index].isSelected = !devices[index].isSelected!;
      badgeCounterTotal = badgeCounterTotal + 1;
    }
    notifyListeners();
  }

  void changeProductPrice(int index, double amount) {
    final currCost = products[index].cost;
    products[index] = products[index].copyWith(cost: currCost + amount);
    notifyListeners();
  }

  //add additionals
  void changeSelectedAdditionalsVideo(int index) {
    for (int i = 0; i < additionalsVideo.length; i++) {
      if (additionalsVideo[i].isSelected == true) {
        additionalsVideo[i].isSelected = false;
        additionalsTVPrice = additionalsTVPrice - additionalsVideo[i].cost;
        additionalsVideoSelected.remove(additionalsVideo[i]);
        additionals.remove(additionalsVideo[i]);
        badgeCounterTotal = badgeCounterTotal - 1;
      } else {
        if (i == index) {
          additionalsVideo[i].isSelected = true;
          additionalsTVPrice = additionalsTVPrice + additionalsVideo[i].cost;
          additionalsVideoSelected.add(additionalsVideo[i]);
          additionals.add(additionalsVideo[i]);
          badgeCounterTotal = badgeCounterTotal + 1;
        } else {
          additionalsVideo[i].isSelected = false;
        }
      }
    }
    notifyListeners();
  }

  void changeSelectedAdditionalsRecording(int index) {
    // print(packsPremium[index].name);
    for (int i = 0; i < additionalsRecording.length; i++) {
      if (additionalsRecording[i].isSelected == true) {
        additionalsRecording[i].isSelected = false;
        additionalsTVPrice = additionalsTVPrice - additionalsRecording[i].cost;
        additionalsRecordingSelected.remove(additionalsRecording[i]);
        additionals.remove(additionalsRecording[i]);
        badgeCounterTotal = badgeCounterTotal - 1;
      } else {
        if (i == index) {
          additionalsRecording[i].isSelected = true;
          additionalsTVPrice =
              additionalsTVPrice + additionalsRecording[i].cost;
          additionalsRecordingSelected.add(additionalsRecording[i]);
          additionals.add(additionalsRecording[i]);
          badgeCounterTotal = badgeCounterTotal + 1;
        } else {
          additionalsRecording[i].isSelected = false;
        }
      }
    }
    notifyListeners();
  }

  void changeSelectedPackPremium(int index) {
    if (packsPremium[index].isSelected == true) {
      packsPremiumSelected.remove(packsPremium[index]);
      additionals.remove(packsPremium[index]);
      badgeCounterTotal = badgeCounterTotal - 1;
      additionalsTVPrice = additionalsTVPrice - packsPremium[index].cost;
      packsPremium[index].isSelected = false;
    } else {
      additionalsTVPrice = additionalsTVPrice + packsPremium[index].cost;
      packsPremium[index].isSelected = true;
      packsPremiumSelected.add(packsPremium[index]);
      additionals.add(packsPremium[index]);
      badgeCounterTotal = badgeCounterTotal + 1;
    }

    notifyListeners();
  }

//add products
  void addToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }

//add additionals
  void addAdditionalToCart(Product product) {
    additionals.add(product);
    additionalsVoice = additionalsVoice + product.cost;
    notifyListeners();
  }

//add additionals
  void removeFromAdditionalCart(String id) {
    double removeCost = getCostAdditional(id);
    additionalsVoice = additionalsVoice - removeCost;
    additionals.removeWhere((element) => (element.id == id));
    notifyListeners();
  }

  double getCostAdditional(String id) {
    double cost = 0;

    for (int i = 0; i < additionals.length; i++) {
      if (additionals[i].id == id) {
        cost = additionals[i].cost;
      }
    }

    return cost;
  }

//add devices
  void addDeviceToCart(Product product) => devices.add(product);

  void removeDeviceFromCart(Product product) {
    devices.remove(product);
    notifyListeners();
  }

  //add fees
  void addFeesToCart(List<Product> fees) {
    for (var fee in fees) {
      this.fees.add(fee);
    }
    notifyListeners();
  }

  //add packsPremiumChannels
  void addPacksPremiumChannels(List<Product> packsPremiumChannels) {
    for (var pack in packsPremiumChannels) {
      packsPremium.add(pack);
    }
    notifyListeners();
  }

  void removeFeeFromCart(Product product) {
    fees.remove(product);
    notifyListeners();
  }

  void productUnselected(Product product) {
    products.removeWhere((e) => e.name == product.name);

    notifyListeners();
  }

  validateAddProduct(Product product) {
    //Identifica si en la lista de productos no hay nada para agregarlo directamente
    if (products.isEmpty) {
      products.add(product);
    }

    //Consulta si en toda la lista de productos hay algún item de la misma categoría que se quiere agregar
    else {
      List<Product> contains =
          products.where((item) => item.category == product.category).toList();

      //Si no se encuentran elementos de la misma categoría, no hay problema en agregar el producto
      if (contains.isEmpty) {
        products.add(product);
      }

      //Si sí encontró un producto de la misma categoría, lo elimina y agrega el nuevo seleccionado
      else {
        products.remove(contains.first);
        products.add(product);
      }
    }
    notifyListeners();
  }

  void discountRules() {
    bundlesDiscount();
  }

  // void promoRules() {
  //   print("Aplicar descuentos aqui");
  //   notifyListeners();
  // }

  void createPromoGrateful(String id, String name, String cost, String category,
      String pwName, String service) {
    Product actualBundleGrateful = Product(
      id: id,
      name: name,
      cost: double.parse(cost),
      imageurl: "",
      service: service,
      category: category,
      quantity: 1,
      pwName: pwName,
    );

    fees.add(actualBundleGrateful);
  }

  void createPromoDiscount(String id, String name, String cost, String category,
      String pwName, String service) {
    Product actualBundleDiscount = Product(
        id: id,
        name: name,
        cost: double.parse(cost),
        imageurl: "",
        service: service,
        category: category,
        quantity: 1,
        pwName: pwName);

    discounts.add(actualBundleDiscount);
    notifyListeners();
  }

  bundlesDiscount() {
    //Cantidad de productos seleccionados
    productsCategoryQty = products.where((p) => !p.name.contains("G1")).length;

    //switch temporal
    switch (productsCategoryQty) {
      case 0:
      case 1:
        discounts.clear();
        break;

      case 2:
        bundleDiscount = 0.05;
        checkDiscount(bundleDiscount, productsCategoryQty);
        break;

      case 3:
        bundleDiscount = 0.10;
        checkDiscount(bundleDiscount, productsCategoryQty);
        break;

      default:
        break;
    }

    notifyListeners();
  }

  checkDiscount(double bundleDiscount, productsQty) {
    var totalprod =
        products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.cost;
    });

    //Verificacion de productos seleccionados para descuento por no. Productos
    var checkDiscount = discounts.where((item) => item.id == "bundleDiscount");
    var discountValue = totalprod * bundleDiscount;

    if (checkDiscount.isNotEmpty) {
      //Buscar discount con id=bundleDiscount y actualizarlo

      var discountUpdate =
          discounts.firstWhere((element) => element.id == "bundleDiscount");
      discountUpdate = discountUpdate.copyWith(
          cost: discountValue,
          name: "Bundling discount ${bundleDiscount * 100}%",
          category: "${productsQty}PlayDiscounts");
      discounts.removeWhere((element) => element.id == "bundleDiscount");
      discounts.add(discountUpdate);
    } else {
      discounts.add(
          createBundleDiscount(bundleDiscount, discountValue, productsQty));
    }

    notifyListeners();
  }

  Product createBundleDiscount(
      double bundleDiscount, double discountValue, int productsQty) {
    Product actualBundleDiscount = Product(
        id: 'bundleDiscount',
        name: "Bundling discount ${bundleDiscount * 100}%",
        cost: discountValue,
        imageurl: "",
        service: "BundleDiscount",
        category: "${productsQty}PlayDiscounts",
        quantity: 1,
        pwName: "Bundle Discount");

    return actualBundleDiscount;
  }

  void clearProductsGigFastTV() {
    additionalsTVPrice = 0;
    totalDevices = 0;
    badgeCounterTotal = 0;
    isSupportedDevicesVisible = true;
    packsPremiumSelected.clear();
    packsPremium.clear();
    additionalsVideoSelected.clear();
    additionalsVideo.clear();
    additionalsRecordingSelected.clear();
    additionalsRecording.clear();
    moviesbundle.clear();
    moviesBundleSelected.clear();
    devices.clear();
    additionalsDevicesSelected.clear();
    //category almacena el campo family del API
    additionals.removeWhere((element) =>
        element.category.contains('tv') || element.category == "gigFastTV");
    fees.removeWhere((element) => element.category == 'gigFastTV');
    discounts.removeWhere((element) => element.category == 'gigFastTV');
    notifyListeners();
  }

  void clearProductsGigFastVoice() {
    additionalsVoice = 0;
    //category almacena el campo family del API
    additionals.removeWhere((element) => element.category == 'gigFastVoice');
    fees.removeWhere((element) => element.category == 'gigFastVoice');
    discounts.removeWhere((element) => element.category == 'gigFastVoice');
    additionalsLine.clear();
    notifyListeners();
  }

  void clearProductsGigFastInternet() {
    //category almacena el campo family del API
    fees.removeWhere((element) => element.category == 'gigFastInternet');
    discounts.removeWhere((element) => element.category == 'gigFastInternet');
    promoGratefulSwitcher = false;
    promoSMSwitcher = false;
    notifyListeners();
  }

  void clearAllProducts() {
    additionalsTVPrice = 0;
    badgeCounterTotal = 0;
    totalDevices = 0;
    additionalsVoice = 0;
    isSupportedDevicesVisible = true;
    packsPremiumSelected.clear();
    packsPremium.clear();
    additionalsVideoSelected.clear();
    additionalsVideo.clear();
    additionalsRecordingSelected.clear();
    additionalsRecording.clear();
    moviesbundle.clear();
    moviesBundleSelected.clear();
    devices.clear();
    additionalsDevicesSelected.clear();
    additionals.clear();
    additionalsLine.clear();
    products.clear();
    fees.clear();
    discounts.clear();
    notifyListeners();
  }

  convertPromoToProduct(Products promo) {
    return Product(
        id: promo.id!,
        name: promo.name!,
        cost: double.parse(promo.price!),
        imageurl: "",
        service: "promo",
        category: promo.family!,
        quantity: 1,
        pwName: promo.pwName!);
  }

  addPromoToCart(Products promo) {
    Product promoProduct = convertPromoToProduct(promo);

    promo.family!.contains("Fees")
        ? fees.add(promoProduct)
        : discounts.add(promoProduct);
  }

  removePromoFromCart(Products promo) {
    promo.family!.contains("Fees")
        ? fees.removeWhere((fee) => fee.id == promo.id)
        : discounts.removeWhere((discount) => discount.id == promo.id);
    notifyListeners();
  }

  cleanPromos() {
    fees.removeWhere((fee) => fee.service.contains("promo"));
    discounts.removeWhere((discount) => discount.service.contains("promo"));
  }

  cleanByCategory(String planCategory) {
    String category = planCategory.toLowerCase();

    if (category.contains('tv')) {
      clearProductsGigFastTV();
    } else if (category.contains('internet')) {
      clearProductsGigFastInternet();
    } else if (category.contains('voice')) {
      clearProductsGigFastVoice();
    }
  }
}
