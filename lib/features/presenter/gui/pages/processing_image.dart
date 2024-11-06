import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

@RoutePage()
class ProcessingImagePage extends StatefulWidget {
  final XFile imageFile;

  const ProcessingImagePage(this.imageFile, {super.key});

  @override
  State<ProcessingImagePage> createState() => _ProcessingImagePageState();
}

class _ProcessingImagePageState extends State<ProcessingImagePage> {
  double identifyPercentage = 0.0;
  final logger = Logger();
  List<Map<String, dynamic>> diseases = []; // List to store parsed diseases data

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  // Method to simulate progress and call the API when done
  void _simulateProgress() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (identifyPercentage >= 100.0) {
        timer.cancel();
        await _processImage(); // Call the API after progress is complete
        _showResult();
      } else {
        setState(() {
          identifyPercentage += 2; // Adjust for faster or slower progress
        });
      }
    });
  }

  // Method to call the API and process the response
  Future<void> _processImage() async {
    final url = Uri.parse("https://chicken-disease-prediction-uvky.onrender.com/");
    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', widget.imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);

        setState(() {
          diseases = List<Map<String, dynamic>>.from(responseData['diseases']);
        });
        logger.d("Diseases identified: $diseases");
      } else {
        logger.e("Failed to identify diseases: ${response.statusCode}");
        setState(() {
          diseases = [
            {
              "disease": "Error",
              "symptoms": ["Unable to identify disease"],
              "treatment": "Please try again"
            }
          ];
        });
      }
    } catch (e) {
      logger.e("Error processing image: $e");
      setState(() {
        diseases = [
          {
            "disease": "Error",
            "symptoms": ["Network or server error"],
            "treatment": "Please try again later"
          }
        ];
      });
    }
  }

  // Show the result dialog with the API result
  void _showResult() {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Identified Disease Report",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: diseases.length,
                  itemBuilder: (context, index) {
                    final disease = diseases[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Disease: ${disease['disease']}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Symptoms:",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ...List<Widget>.from(disease['symptoms'].map((symptom) {
                            return Text(
                              "- $symptom",
                              style: const TextStyle(fontSize: 14),
                            );
                          })),
                          const SizedBox(height: 8),
                          Text(
                            "Treatment: ${disease['treatment']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Divider(thickness: 1, color: Colors.grey),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const HomeRoute());
                        },
                        child: const Icon(Icons.home)),
                    ElevatedButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const CameraRoute());
                        },
                        child: const Icon(Icons.camera))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Processing Image"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.file(
              width: _w,
              File(widget.imageFile.path),
              fit: BoxFit.cover,
            ),
          ),
          Visibility(
            child: Expanded(
              flex: 2,
              child: Container(
                color: AppColors.pageBg,
                width: _w,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text("Wait for a moment"),
                      Text("Identifying: ${identifyPercentage.toStringAsFixed(1)}%"),
                      const SizedBox(height: 25),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            width: 70,
                            height: 70,
                            child: CircularProgressIndicator(
                              strokeWidth: 8,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              "assets/broyalty_logo.png",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
