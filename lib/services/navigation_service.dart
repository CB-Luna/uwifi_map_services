import 'package:flutter/material.dart';

//Esta clase permite la navegacion a un layout completamente diferente
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
  //para reemplazar la pantalla sin guardar el historial
  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
