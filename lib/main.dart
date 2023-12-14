import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_map_services/helpers/constants.dart';
import 'package:uwifi_map_services/helpers/globals.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_cc_provider.dart';
import 'package:uwifi_map_services/router/router.dart';
import 'package:uwifi_map_services/services/navigation_service.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uuid/uuid.dart';

import 'providers/tracking_provider.dart';

void main() async {
  Flurorouter.configureRoutes();
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  supabaseAuth = SupabaseClient(supabaseUrl, anonKey, schema: 'auth');

  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Provider para cambio de pantallas
        ChangeNotifierProvider<TrackingProvider>(
          create: (_) {
            var uuidConstruct = const Uuid();
            var uuid = uuidConstruct.v1();

            return TrackingProvider(uuid);
          },
        ),
        //Provider para carrito de compras
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        //Provider para customer Personal Details, Shipping Details y Credit Card
        ChangeNotifierProvider(create: (_) => CustomerPDSDCCProvider(notify: false)),
        ChangeNotifierProvider<CustomerInfoProvider>(
          create: (_) => CustomerInfoProvider(
          ),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'UWIFI Map Services',
        debugShowCheckedModeBanner: false,
        initialRoute: Flurorouter.rootRoute,
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        theme: defaultTheme);
  }
}
