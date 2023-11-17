import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/location_phone_controller.dart';
import 'package:uwifi_map_services/providers/number_form_provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/referal_providers/portability_form_provider_r.dart';
import 'package:uwifi_map_services/providers/referal_providers/screen_controller.dart';
import 'package:uwifi_map_services/providers/remote/suggestions_api.dart';
import 'package:uwifi_map_services/providers/search_controller_portability.dart';
import 'package:uwifi_map_services/providers/search_controller_portability_r.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/providers/voice_popup_controller.dart';
import 'package:uwifi_map_services/router/router.dart';
import 'package:uwifi_map_services/services/navigation_service.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uuid/uuid.dart';

import 'data/repositories_impl/suggestions_repository_impl.dart';
import 'providers/tracking_provider.dart';

void main() {
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TrackingProvider>(
          create: (_) {
            var uuidConstruct = const Uuid();
            var uuid = uuidConstruct.v1();

            return TrackingProvider(uuid);
          },
        ),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ChangeNotifierProvider<TVPopupController>(
          create: (_) => TVPopupController(),
        ),
        ChangeNotifierProvider<VoicePopupController>(
          create: (_) => VoicePopupController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PortabilityFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NumberFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PortabilityFormProviderR(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationPhoneController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScreenController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectorSummaryController(),
        ),
        ChangeNotifierProvider<SearchControllerPortabilityR>(
          create: (_) => SearchControllerPortabilityR(
              SuggestionsRepositoryImpl(
                SuggestionsAPI(Dio()),
              ),
              UniqueKey()),
        ),
        ChangeNotifierProvider<SearchControllerPortability>(
          create: (_) => SearchControllerPortability(
              SuggestionsRepositoryImpl(
                SuggestionsAPI(Dio()),
              ),
              UniqueKey()),
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
        title: 'Maps',
        debugShowCheckedModeBanner: false,
        initialRoute: Flurorouter.rootRoute,
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        theme: defaultTheme);
  }
}
