import 'package:fluro/fluro.dart';
import 'package:uwifi_map_services/router/admin_handlers.dart';
import 'package:uwifi_map_services/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth router
  static String salesRoute = 'sales';

  static String formRoute = '/form';


  static void configureRoutes() {
    // Auth Routes
    router.define(
      rootRoute,
      handler: AdminHandlers.productPage,
      transitionType: TransitionType.none,
    );

    router.define(
      salesRoute,
      handler: AdminHandlers.productPage,
      transitionType: TransitionType.none,
    );

    router.define(formRoute,
        handler: AdminHandlers.formPage, transitionType: TransitionType.none);
    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
