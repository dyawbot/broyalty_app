import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<File> _imageFiles = [];
  final logger = Logger();
  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      // Get the external storage directory (where the image is saved)
      Directory? storageDirectory = await getExternalStorageDirectory();

      if (storageDirectory == null) {
        throw Exception("External storage is not available.");
      }

      // Path where images are saved
      String directoryPath = path.join(storageDirectory.path, 'CapturedImages');

      // Ensure the directory exists
      Directory imageDirectory = Directory(directoryPath);
      if (!await imageDirectory.exists()) {
        await imageDirectory.create(recursive: true);
      }

      // Get the list of files in the directory
      List<FileSystemEntity> files = imageDirectory.listSync();

      // Filter the list to include only image files (e.g., .jpg, .png)
      List<File> images = files
          .where((file) =>
              file.path.endsWith('.jpg') || file.path.endsWith('.png'))
          .map((file) => File(file.path))
          .toList();

      // Update the state with the list of images
      setState(() {
        _imageFiles = images;
      });
    } catch (e) {
      print("Error loading images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: _imageFiles.isNotEmpty
          ? ListView.builder(
              itemCount: _imageFiles.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.analogMainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.file(
                    _imageFiles[index], // Display the image
                    fit: BoxFit.cover,
                  ),
                );
              },
            )
          : const Center(child: Text('No images found')),
    );
  }
}
