// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CameraScreen(),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   late List<CameraDescription> _cameras;
//   bool _isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//     initTFLite();
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   void initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
//     await _cameraController.initialize();

//     if (!mounted) return;

//     setState(() {
//       _isCameraInitialized = true;
//     });

//     _cameraController.startImageStream((CameraImage image) {
//       if (DateTime.now().millisecondsSinceEpoch % 500 == 0) {
//         runObjectDetector(image);
//       }
//     });
//   }

//   void initTFLite() async {
//     await Tflite.loadModel(
//         model: "assets/model.tflite",
//         labels: "assets/labels.txt",
//         numThreads: 1, // defaults to 1
//         isAsset:
//             true, // defaults to true, set to false to load resources outside assets
//         useGpuDelegate: false);
//   }

//   void runObjectDetector(CameraImage image) async {
//     var recognitions = await Tflite.detectObjectOnFrame(
//         bytesList: image.planes.map((plane) {
//           return plane.bytes;
//         }).toList(), // required

//         imageHeight: image.height,
//         imageWidth: image.width,
//         imageMean: 0, // defaults to 127.5
//         imageStd: 255.0, // defaults to 127.5
//         threshold: 0.1, // defaults to 0.1
//         numResultsPerClass: 2, // defaults to 5
//         blockSize: 32, // defaults to 32
//         numBoxesPerBlock: 5, // defaults to 5
//         asynch: true // defaults to true
//         );

//     if (recognitions != null && recognitions.isNotEmpty) {
//       for (var recognition in recognitions) {
//         var label = recognition["label"];
//         var confidence = recognition["confidence"];
//         var rect = recognition["rect"] as Map<String, double>;

//         var x = rect["x"]! * image.width!;
//         var y = rect["y"]! * image.height!;
//         var w = rect["w"]! * image.width!;
//         var h = rect["h"]! * image.height!;

//         print("Detected: $label ($confidence) at x: $x, y: $y, w: $w, h: $h");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isCameraInitialized) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     return Scaffold(
//       body: CameraPreview(_cameraController),
//     );
//   }
// }
