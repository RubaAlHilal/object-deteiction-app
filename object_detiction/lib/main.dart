import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:object_detiction/screens/test2.dart';
import 'package:object_detiction/screens/test3.dart';

// late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // cameras = await availableCameras();
  FlutterTts flutterTts = FlutterTts();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TfliteModelTest3(),
    );
  }
}
