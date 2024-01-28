// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:object_detiction/main.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     super.key,
//   });

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// late CameraController cameraController;
// late CameraImage imgCamera;
// bool isWoorking = false;
// String result = '';

// initCamera() {
//   cameraController = CameraController(
//     cameras[0],
//     ResolutionPreset.medium,
//   );
//   cameraController.initialize().then((value) {
//     cameraController.startImageStream((image) => {
//           if (!isWoorking)
//             {
//               isWoorking = true,
//               imgCamera = image,
//             }
//         });
//   });
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Hello World!'),
//       ),
//     );
//   }
// }
