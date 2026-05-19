import 'dart:ui';

class FaceResult {
  FaceResult({
    required this.boundingBox,
    required this.emotion,
    required this.confidence,
  });

  final Rect boundingBox;
  final String emotion;
  final double confidence;
}
