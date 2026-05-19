import 'package:flutter/material.dart';

import 'ui/emotion_camera_page.dart';

void main() {
  runApp(const EmotionCamApp());
}

class EmotionCamApp extends StatelessWidget {
  const EmotionCamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmotionCameraPage(),
    );
  }
}
