import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this line for image picking
import 'package:http/http.dart' as http;
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
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

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
      _cameras[0],
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
        return;
      }

      final XFile image = await _controller.takePicture();
      String savedImagePath = await _saveImageToStorage(image);
      logger.d("Image saved to: $savedImagePath");

      bool uploadSuccess = await _uploadImage(File(savedImagePath));
      if (uploadSuccess) {
        logger.d("Image uploaded successfully");
      } else {
        logger.e("Image upload failed");
      }

      AutoRouter.of(context).push(ProcessingImageRoute(
        imageFile: XFile(savedImagePath),
      ));
    } catch (e) {
      logger.e("Error capturing image: $e");
    }
  }

  Future<String> _saveImageToStorage(XFile image) async {
    try {
      Directory? storageDirectory = await getExternalStorageDirectory();
      String directoryPath = path.join(storageDirectory!.path, 'CapturedImages');

      await Directory(directoryPath).create(recursive: true);
      String fileName = path.basename(image.path);
      String savedImagePath = path.join(directoryPath, fileName);

      File savedImage = await File(image.path).copy(savedImagePath);
      return savedImage.path;
    } catch (e) {
      logger.e("Error saving image: $e");
      throw Exception("Error saving image to storage");
    }
  }

  // Method to upload image to API
  Future<bool> _uploadImage(File imageFile) async {
    final url = Uri.parse("https://chicken-disease-prediction-uvky.onrender.com/predict");
    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        logger.d("Upload successful: ${response.statusCode}");
        return true;
      } else {
        logger.e("Upload failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      logger.e("Error uploading image: $e");
      return false;
    }
  }

  // Method to select an image from the gallery
  Future<void> _selectImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String savedImagePath = await _saveImageToStorage(image);
      logger.d("Image selected from gallery: $savedImagePath");

      bool uploadSuccess = await _uploadImage(File(savedImagePath));
      if (uploadSuccess) {
        logger.d("Image uploaded successfully");
      } else {
        logger.e("Image upload failed");
      }

      AutoRouter.of(context).push(ProcessingImageRoute(
        imageFile: XFile(savedImagePath),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Column(
        children: [
          Expanded(
            child: _isCameraInitialized
                ? CameraPreview(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _selectImageFromGallery(context),
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload from Gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
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
