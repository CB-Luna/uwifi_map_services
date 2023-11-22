import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/repositories_impl/geocode_repository_impl.dart';
import 'package:uwifi_map_services/data/repositories_impl/suggestions_repository_impl.dart';
import 'package:uwifi_map_services/providers/remote/geocode_api.dart';
import 'package:uwifi_map_services/providers/remote/suggestions_api.dart';
import 'package:uwifi_map_services/providers/search_controller.dart';
import 'package:uwifi_map_services/ui/layouts/map/widgets/custom_title.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/map_view.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/form_view.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  SearchLocalController controller = SearchLocalController(
    SuggestionsRepositoryImpl(
      SuggestionsAPI(Dio()),
    ),
    GeocodeRepositoryImpl(
      GeocodeAPI(Dio()),
    ),
    UniqueKey(),
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<SearchLocalController>.value(
      value: controller,
      // key: ,
      child: Scaffold(body: chooseBody(size)),
    );
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print('Entered AuthLayout dispose() - key: ${widget.key}');
    controller.dispose();
    super.dispose();
  }

  Widget chooseBody(size) {
    if (size.width > 600) {
      return const _DesktopBody();
    } else {
      return const _MobileBody();
    }
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchLocalController>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        searchController.clearPlaces();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: buildBoxDecoration('images/bg_image.png'),
              child: const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomTitle(
                    mobile: true,
                  ),
                  FormView(),
                ],
              ),
            ),
          ),
          // const Expanded(child: MapView()),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchController = Provider.of<SearchLocalController>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        searchController.clearPlaces();
      },
      child: Row(
        children: [
          Container(
            decoration: buildBoxDecoration('images/bg_image.png'),
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTitle(),
                  FormView(),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height,
          //   width: size.width * 0.57,
          //   child: const MapView(),
          // ),
        ],
      ),
    );
    // );
  }
}

BoxDecoration buildBoxDecoration(String image) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(image),
      fit: BoxFit.cover,
    ),
  );
}
