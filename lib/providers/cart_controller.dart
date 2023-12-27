import 'package:flutter/material.dart';
import '../classes/plan.dart';
import '../classes/product.dart';

class Cart with ChangeNotifier {
  double bundleDiscount = 0;
  int productsCategoryQty = 0;
  int badgeCounterTotal = 0;
  bool isSelected = false;
  bool isSupportedDevicesVisible = true;
  bool buttonVisible = true;
  bool aciveToogle = false;
  List<Product> products = [Product(
        id: 'uwifiService',
        name: "U-wifi Service Plan",
        cost: 30.0,
        imageurl: "",
        service: "uwifiPlan",
        category: "plan",
        quantity: 1,
        pwName: "U-wifi Service Plan")];
  List<Product> devices = [];
  List<Product> additionalsDevicesSelected = [];
  List<Product> discounts = [];
  

  int get generalCartCounter {
    var counter = products.length;
    return counter;
  }

  double get total {
    var totalprod =
        products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.cost;
    });


    var subtotal = totalprod;

    return subtotal;
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



  void changeVisibilitySupportedDevices() {
    isSupportedDevicesVisible = !isSupportedDevicesVisible;
    notifyListeners();
  }


  void changeProductPrice(int index, double amount) {
    final currCost = products[index].cost;
    products[index] = products[index].copyWith(cost: currCost + amount);
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
    badgeCounterTotal = 0;
    isSupportedDevicesVisible = true;
    notifyListeners();
  }


  void clearAllProducts() {
    badgeCounterTotal = 0;
    isSupportedDevicesVisible = true;
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

}
