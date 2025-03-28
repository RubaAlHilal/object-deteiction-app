// import 'dart:developer';

// import 'package:camera/camera.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ScanController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     initCamera();
//     initTFLite();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     cameraController.dispose();
//   }

//   late CameraController cameraController;
//   late List<CameraDescription> cameras;

//   var cameraCount = 0;

//   var isCameraInitilized = false.obs;

//   initCamera() async {
//     if (await Permission.camera.request().isGranted) {
//       cameras = await availableCameras();
//       // cameras[0] => rear camera
//       cameraController = CameraController(cameras[0], ResolutionPreset.medium,
//           imageFormatGroup: ImageFormatGroup.yuv420);
//       await cameraController.initialize().then((value) {
//         cameraCount++;
//         cameraController.startImageStream((image) {
//           if (cameraCount % 10 == 0) {
//             cameraCount = 0;
//             objectDetector(image);
//             print("count");
//           }
//           update();
//         });
//       });
//       print("permision");
//       isCameraInitilized(true);
//       update();
//     } else {
//       print("permision denied");
//     }
//   }

//   initTFLite() async {
//     await Tflite.loadModel(
//         model: "assets/model.tflite",
//         labels: "assets/labels.txt",
//         isAsset: true,
//         numThreads: 1,
//         useGpuDelegate: false);
//   }

//   objectDetector(CameraImage image) async {
//     var detector = await Tflite.runModelOnFrame(
//       bytesList: image.planes.map((e) {
//         return e.bytes;
//       }).toList(),
//       asynch: true,
//       imageHeight: image.height,
//       imageWidth: image.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       rotation: 90,
//       threshold: 0.4,
//     );

//     if (detector != null) {
//       log("result id $detector");
//     }
//   }
// }
