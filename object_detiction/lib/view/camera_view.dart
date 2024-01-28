// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:object_detiction/controller/scan_controller.dart';

// class CameraScreen extends StatelessWidget {
//   const CameraScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<ScanController>(
//           init: ScanController(),
//           builder: (controller) {
//             return controller.isCameraInitilized.value
//                 ? Stack(children: [
//                     CameraPreview(controller.cameraController),
//                     Container(
//                       width: 200,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.green,
//                           ),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                               color: Colors.white, child: Text("label object")),
//                         ],
//                       ),
//                     )
//                   ])
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   );
//           }),
//     );
//   }
// }
