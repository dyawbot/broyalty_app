import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
    logger.d("Capturing image...");
    try {
      if (!_controller.value.isInitialized) {
        logger.e("Error: Camera is not initialized.");
        return;
      }

      if (_controller.value.isTakingPicture) {
        return; // Capture already in progress
      }

      final XFile image = await _controller.takePicture();
      // logger.d("Image captured: ${image.path}");

      // Save the image to external storage
      String savedImagePath = await _saveImageToStorage(image);
      logger.d("Image saved to: $savedImagePath");

      // Navigate to the processing page with the saved image
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).push(ProcessingImageRoute(
        imageFile: XFile(savedImagePath),
      ));
    } catch (e) {
      logger.e("Error capturing image: $e");
    }
  }

  Future<String> _saveImageToStorage(XFile image) async {
    try {
      // Get the directory to store images (e.g., external storage directory)
      Directory? storageDirectory = await getExternalStorageDirectory();
      String directoryPath =
          path.join(storageDirectory!.path, 'CapturedImages');

      // Create directory if it doesn't exist
      await Directory(directoryPath).create(recursive: true);

      // Construct a file path for the image
      String fileName = path.basename(image.path); // Use original file name
      String savedImagePath = path.join(directoryPath, fileName);

      // Copy the image to the new location
      File savedImage = await File(image.path).copy(savedImagePath);
      return savedImage.path;
    } catch (e) {
      logger.e("Error saving image: $e");
      throw Exception("Error saving image to storage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: _isCameraInitialized
          ? CameraPreview(_controller)
          : const Center(child: CircularProgressIndicator()),
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
