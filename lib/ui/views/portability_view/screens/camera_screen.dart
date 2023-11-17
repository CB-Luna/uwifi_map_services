// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum WidgetState { none, loading, loaded, error, display }

class _CameraScreenState extends State<CameraScreen> {
  WidgetState _widgetState = WidgetState.none;
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  Image? _image;

  @override
  void initState() {
    print('************Inicializando Camara**********');
    super.initState();
    initializeCamera();
  }

  Future<void> cleanDataCamera() async {
    print('************Cerrando Camara**********');
    _widgetState = WidgetState.none;
    _cameras = [];
    await _cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_widgetState) {
      case WidgetState.none:
        return _buildScafold(context, Center(child: _isLoading()));
      case WidgetState.loading:
        return _buildScafold(
            context,
            Center(
              child: _isLoading(),
            ));
      case WidgetState.loaded:
        return _buildScafold(context, CameraPreview(_cameraController!));
      case WidgetState.error:
        return _buildScafold(
            context,
            const Center(
              child: Text("Camera Failed"),
            ));
      case WidgetState.display:
        return _displayImage(context, _image!);
    }
  }

  Widget _buildScafold(BuildContext context, Widget body) {
    final size = MediaQuery.of(context).size;
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: body,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 5.0,
                color: const Color(0xff2E5899),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: IconButton(
                            iconSize: 25,
                            onPressed: () {
                              selectorSummaryController.changeView(1);
                              portabilityFormProvider.cleanLastBillFile();
                              cleanDataCamera();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Take a picture',
                          style: GoogleFonts.workSans(
                            color: const Color(0xffE0E4EC),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: const Color(0xFFD20030),
                    onPressed: () async {
                      XFile xfile = await _cameraController!.takePicture();
                      final bytes = await xfile.readAsBytes();
                      _image = Image.memory(bytes, fit: BoxFit.cover);
                      // print("*****File Name: ${xfile.name}");
                      // print("*****File Path: ${xfile.path}");
                      portabilityFormProvider.changeLastBillFile(
                          xfile.path, bytes);
                      _widgetState = WidgetState.display;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: const Icon(Icons.camera),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayImage(BuildContext context, Widget body) {
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: const Color(0xFFD20030),
                    onPressed: () {
                      resetCamera();
                    },
                    child: const Icon(Icons.cancel_outlined),
                  ),
                  FloatingActionButton(
                    backgroundColor: const Color(0xff2E5899),
                    onPressed: () {
                      selectorSummaryController.changeView(1);
                      cleanDataCamera();
                    },
                    child: const Icon(Icons.check_circle_outline),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future initializeCamera() async {
    _widgetState = WidgetState.loading;
    if (mounted) {
      setState(() {});
    }

    _cameras = await availableCameras();
    print("Numero de camaras : ${_cameras.length}");
    _cameraController = CameraController(_cameras[1], ResolutionPreset.high);

    await _cameraController!.initialize();

    if (_cameraController!.value.hasError) {
      _widgetState = WidgetState.error;
      if (mounted) {
        setState(() {});
      }
    } else {
      _widgetState = WidgetState.loaded;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future resetCamera() async {
    _widgetState = WidgetState.loading;
    if (mounted) {
      setState(() {});
    }

    await _cameraController!.initialize();

    if (_cameraController!.value.hasError) {
      _widgetState = WidgetState.error;
      if (mounted) {
        setState(() {});
      }
    } else {
      _widgetState = WidgetState.loaded;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget _isLoading() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SpinKitCircle(
            size: 200,
            itemBuilder: (context, index) {
              final colors = [
                const Color(0xFFD20030),
                Colors.white,
                const Color(0xffB6D9F9)
              ];
              final color = colors[index % colors.length];
              return DecoratedBox(
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              );
            },
          ),
          SizedBox(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'Work Sans',
                color: Colors.white,
                fontSize: 20,
              ),
              child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                FadeAnimatedText('Loading'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
