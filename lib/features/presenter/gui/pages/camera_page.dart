import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../constant/color.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final logger = Logger();
  List<CameraDescription> _cameras = [];

  late CameraController _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[0], // Select the first camera
      ResolutionPreset.high,
    );

    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  // Method to capture image
  Future<void> _captureImage(BuildContext context) async {
    logger.d("Captureing");
    try {
      if (!_controller.value.isInitialized) {
        // Show error if camera is not initialized
        logger.e("Error: Camera is not initialized.");
        return;
      }

      // Check if the camera is ready to take a picture
      if (_controller.value.isTakingPicture) {
        // A capture is already pending, do nothing.
        return;
      }

      // Take the picture
      final XFile image = await _controller.takePicture();

      // Do something with the captured image, like displaying it or saving it
      logger.d("Image captured: ${image.path}");

      // Example: Display the captured image
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     content: Image.file(File(image.path)),
      //     actions: [
      //       TextButton(
      //         child: Text('Close'),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ],
      //   ),
      // );

      AutoRouter.of(context).push(ProcessingImageRoute(
        imageFile: image,
      ));
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: _isCameraInitialized
          ? CameraPreview(_controller)
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        // mini: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () => _captureImage(context),
        child: const Icon(
          Icons.camera,
          color: AppColors.comMainColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
