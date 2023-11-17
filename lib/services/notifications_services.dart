import 'package:flutter/material.dart';

class NotificationsService {
  
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>(); 
  
  
  static showSnackbarError(String message) { //Mostrar las notificaciones sin importar donde se encuentre la aplicacion, se dispara hasta que la plicacion este creada APP del main

    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbar(String message) { //Mostrar las notificaciones sin importar donde se encuentre la aplicacion, se dispara hasta que la plicacion este creada APP del main

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

}