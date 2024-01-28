import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TfliteModelTest3 extends StatefulWidget {
  const TfliteModelTest3({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModelTest3> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late List _results = []; // Initialize _results as an empty list
  bool imageSelect = false;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    loadModel();
    _initializeCamera();
  }

  Future<void> speakResults() async {
    String textToSpeak = "";
    for (Map<String, dynamic> result in _results) {
      String label = result['label'];
      double confidence = result['confidence'];
      textToSpeak +=
          "$label with confidence ${confidence.toStringAsFixed(2)}. ";
    }

    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(textToSpeak);
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    ))!;
    print("Models loading status: $res");
  }

  Future _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      _cameraController.startImageStream((image) {
        imageClassification(image);
      });
    });
  }

  Future imageClassification(CameraImage image) async {
    try {
      final List? recognitions = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 6,
        threshold: 0.05,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        print("Recognitions type: ${recognitions.runtimeType}");

        // Handle the case where recognitions is not of type Map<String, dynamic>
        setState(() {
          _results = recognitions;
          imageSelect = true;
        });

        speakResults();
      }
    } catch (e) {
      print("Error in imageClassification: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController.value.isInitialized) {
      print("Results: $_results");
      print("Typed Recognitions: $_results");
      print("lllllllllllllllllllllllllllllll");
      return Scaffold(
        appBar: AppBar(
          title: const Text("Object Classification"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CameraPreview(_cameraController),
              Column(
                children: (imageSelect)
                    ? _results.map((result) {
                        return Card(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Text(
                              "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    : [],
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
