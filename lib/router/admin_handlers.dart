// ignore_for_file: avoid_print

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/router/promo_params.dart';
import 'package:uwifi_map_services/router/router.dart';
import 'package:uwifi_map_services/ui/layouts/sales/sales_layout.dart';
import 'package:uwifi_map_services/router/query_params.dart';
import 'package:uwifi_map_services/ui/layouts/map/auth_layout.dart';

import '../providers/tracking_provider.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

String? origin = 'general';

class AdminHandlers {
  static Handler prefillHomePage = Handler(handlerFunc: (context, params) {
    print('Entered prefillHomePage Handler');

    if (params.containsKey('address')) {
      print(params['address']!.length);
      if (params['address']!.isNotEmpty) {
        origin = "Website Form";
        setOrigin(context, origin);
        QueryParams.initAddress(
          "${params['address']?[0]}",
          "${params['zipcode']?[0]}",
        );
      }
    }
    return const AuthLayout();
  });

  static Handler prefillRep = Handler(handlerFunc: (context, params) {
    print('Entered prefillRep Handler');
    if (params.containsKey('rep')) {
      if (params['rep']!.isNotEmpty) {
        print("QueryParams: ${params['rep']?[0]}");
        QueryParams.initCustomerRep("${params['rep']?[0]}");
      }
    }
    return const AuthLayout();
  });

  static Handler prefillOrigin = Handler(handlerFunc: (context, params) {
    print('Entered prefillOrigin Handler');

    if (params.containsKey('origin')) {
      if (params['origin']!.isNotEmpty) {
        if (params['origin']![0].isNotEmpty) {
          origin = params['origin']?[0];
          setOrigin(context, origin);

          print("QueryParams: ${params['origin']?[0]}");
          QueryParams.initOrigin("${params['origin']?[0]}");
        }
      }
    }
    return const AuthLayout();
  });

  static Handler homePage = Handler(handlerFunc: (context, params) {
    print('Entered homePage Handler');
    // The root route is always pushed at the start of the app (even if the route
    // is different). We have to avoid creating the same layout twice to preserve
    // the state
    if (Uri.base.toString().contains('/?') ||
        Uri.base.toString().contains(Flurorouter.salesRoute)) {
      //has query parameters (will be rebuilt anyway)
      return Container();
    } else {
      //no query parameters
      setOrigin(context, origin);
      return const AuthLayout();
    }
  });

  static Handler productPage = Handler(handlerFunc: (context, params) {
    print('Entered productPage Handler');
    final args = context?.settings?.arguments as CustomerInfo?;
    if (args != null) {
      return SalesLayout(
        customerInfo: args,
      );
    } else {
      return const AuthLayout();
    }
  });

  static Handler repProductPage = Handler(handlerFunc: (context, params) {
    print('Entered repProductPage Handler');
    final args = context?.settings?.arguments as CustomerInfo?;
    if (params.containsKey('promo')) {
      PromoParams.initPromoRep("${params['promo']?[0]}");
    }
    if (args != null) {
      return SalesLayout(
        customerInfo: args,
      );
    } else {
      return const AuthLayout();
    }
  });

  static Handler prefillRepTemp = Handler(handlerFunc: (context, params) {
    print('Entered prefillRepTemp Handler');
    return Container();
  });

  static Handler formPage = Handler(handlerFunc: (context, params) {
    print('Entered formPage Handler');
    // if (params.containsKey('rep')) {
    //   if (params['rep']!.isNotEmpty) {
    //     print("QueryParams: ${params['rep']?[0]}");
    //   }
    // }
    return const AuthLayout();
  });
}

setOrigin(context, origin) {
  final tracking = Provider.of<TrackingProvider>(context!, listen: false);
  tracking.recordTrack(initialOrigin: origin, view: "CoverageMapLanding");

  if (origin.contains("social")) {
    js.context.callMethod('fbq', ['track', 'PageView']);

    // js.context['console'].callMethod(
    //     'log', ['Evento de Facebook Pixel PageView ejecutado por JS']);
  }
}
