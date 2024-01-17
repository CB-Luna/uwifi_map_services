import 'package:flutter/material.dart';
import 'package:get/utils.dart';
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
  List<Product> services = [Product(
        id: 'uwifiService',
        name: "U-wifi Service Plan",
        cost: 30.0,
        subtotal: 30.0,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/5G%20Home%20Internet%20Plan.png?t=2024-01-08T22%3A03%3A43.207Z",
        service: "uwifiPlan",
        description: "plan",
        quantity: 1,
        pwName: "U-wifi Service Plan")];
  
  List<Product> merchant = [
    Product(
        id: '1',
        name: "U-wifi Hat",
        cost: 11.99,
        subtotal: 11.99,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/Black%20cap.png?t=2024-01-08T23%3A23%3A05.776Z",
        service: "uwifiPlan",
        description: "Black Baseball style hat, with chrome color U-wifi Logo.",
        quantity: 1,
        pwName: "U-wifi Hat 1"),
    Product(
        id: '2',
        name: "Powerbank 20,000",
        cost: 29.99,
        subtotal: 29.99,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/powerbank%2020000.png",
        service: "uwifiPlan",
        description: "The 20,000 mAh power bank can recharge a smartphone up to 8 consecutive times.",
        quantity: 1,
        pwName: "Powerbank 20,000 2"),
    Product(
        id: '3',
        name: "Powerbank 10,000",
        cost: 19.99,
        subtotal: 19.99,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/powerbank%2010000.png",
        service: "uwifiPlan",
        description: "The 10,000 mAh power bank can recharge a smartphone up to 4 consecutive times.",
        quantity: 1,
        pwName: "Powerbank 10,000 3"),
     Product(
        id: '4',
        name: "U-wifi Phone Case",
        cost: 9.99,
        subtotal: 9.99,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/u-wifi%20phone%20case.png",
        service: "uwifiPlan",
        description: "Cover that protects the outside of your phone and acts as a guard to your gadget against scratches, grime, and other risks.",
        quantity: 1,
        pwName: "U-wifi Phone Case 4"),
     Product(
        id: '5',
        name: "U-wifi Keychain",
        cost: 4.99,
        subtotal: 4.99,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/u-wifi%20keychain.png",
        service: "uwifiPlan",
        description: "Small ring or chain of metal to which several keys can be attached.",
        quantity: 1,
        pwName: "U-wifi Keychain 5"),
      Product(
        id: '6',
        name: "U-wifi Black T-shirt",
        cost: 11.99,
        subtotal: 11.99,
        imageurl: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/U-wifi%20black%20t%20shirt.png",
        service: "uwifiPlan",
        description: "Classic black cotton t-shirt, with withe U-wifi Logo.",
        quantity: 1,
        pwName: "U-wifi Black T-shirt 6")
  ];
  List<Product> additionalsDevicesSelected = [];
  List<Product> discounts = [];
  List<Product> merchantSelected = [];
  

  int get generalCartCounter {
    var totalMerchant =
        merchantSelected.fold(0, (int quantityTotal, Product nextProduct) {
      return quantityTotal + nextProduct.quantity;
    });
    var counter = services.length + totalMerchant;
    return counter;
  }

  double get total {

    var totalServices =
        services.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.subtotal;
    });

    var totalMerchant =
        merchantSelected.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.subtotal;
    });


    var subtotal = (totalMerchant + totalServices).toPrecision(2);

    return subtotal;
  }




  void changeVisibilitySupportedDevices() {
    isSupportedDevicesVisible = !isSupportedDevicesVisible;
    notifyListeners();
  }



//add products
  bool addToCart(String idProductUpdate) {
    // Buscar el índice del producto con el ID dado
    int? productIndex = merchant.indexWhere((product) => product.id == idProductUpdate);

    // Verificar si se encontró el producto
    if (productIndex != -1) {
      Product newProduct = merchant.firstWhere((element) => element.id == idProductUpdate);
      merchant.remove(newProduct);
      merchantSelected.add(newProduct);
      notifyListeners();
      return true;
    } else {
      // El producto con el ID dado no se encontró
      print('Producto con ID $idProductUpdate no encontrado.');
      return false;
    }
  }

  bool removeFromCart(String idProductUpdate) {
    // Buscar el índice del producto con el ID dado
    int? productIndex = merchantSelected.indexWhere((product) => product.id == idProductUpdate);

    // Verificar si se encontró el producto
    if (productIndex != -1) {
      Product newProduct = merchantSelected.firstWhere((element) => element.id == idProductUpdate);
      merchantSelected.remove(newProduct);
      newProduct.quantity = 1;
      newProduct.subtotal = newProduct.cost;
      merchant.add(newProduct);
      notifyListeners();
      return true;
    } else {
      // El producto con el ID dado no se encontró
      print('Producto con ID $idProductUpdate no encontrado.');
      return false;
    }
  }

  bool incrementDecrementQuantityCart(String idProductUpdate, int quantity) {
    // Buscar el índice del producto con el ID dado
    int? productIndex = merchantSelected.indexWhere((product) => product.id == idProductUpdate);

    // Verificar si se encontró el producto
    if (productIndex != -1) {
      // Actualizar la cantidad del producto
      merchantSelected[productIndex].quantity = quantity;
      merchantSelected[productIndex].subtotal = (merchantSelected[productIndex].cost * quantity).toPrecision(2);
      notifyListeners();
      return true;
    } else {
      // El producto con el ID dado no se encontró
      print('Producto con ID $idProductUpdate no encontrado.');
      return false;
    }
  }






  Product createBundleDiscount(
      double bundleDiscount, double discountValue, int productsQty) {
    Product actualBundleDiscount = Product(
        id: 'bundleDiscount',
        name: "Bundling discount ${bundleDiscount * 100}%",
        cost: discountValue,
        imageurl: "",
        service: "BundleDiscount",
        description: "${productsQty}PlayDiscounts",
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
        description: promo.family!,
        quantity: 1,
        pwName: promo.pwName!);
  }

}
