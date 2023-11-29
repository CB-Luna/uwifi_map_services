import 'package:fluro/fluro.dart';
import 'package:uwifi_map_services/router/admin_handlers.dart';
import 'package:uwifi_map_services/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth router
  static String salesRoute = 'sales';

  static String formRoute = '/form';

  static String repSalesRoute = 'salespromo/:promo';

  static String prefillRoute = 'prefill/:address';

  static String repRouteTemp = 'rep';

  static String repRoute = 'rep/:rep';

  static String originRoute = 'origin/:origin';

  static void configureRoutes() {
    // Auth Routes
    router.define(
      rootRoute,
      handler: AdminHandlers.homePage,
      transitionType: TransitionType.none,
    );

    router.define(
      prefillRoute,
      handler: AdminHandlers.prefillHomePage,
      transitionType: TransitionType.none,
    );

    router.define(
      repRoute,
      handler: AdminHandlers.prefillRep,
      transitionType: TransitionType.none,
    );

    router.define(
      repRouteTemp,
      handler: AdminHandlers.prefillRepTemp,
      transitionType: TransitionType.none,
    );

    router.define(
      salesRoute,
      handler: AdminHandlers.productPage,
      transitionType: TransitionType.none,
    );

    router.define(
      repSalesRoute,
      handler: AdminHandlers.repProductPage,
      transitionType: TransitionType.none,
    );

    router.define(
      originRoute,
      handler: AdminHandlers.prefillOrigin,
      transitionType: TransitionType.none,
    );

    router.define(formRoute,
        handler: AdminHandlers.formPage, transitionType: TransitionType.none);
    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
