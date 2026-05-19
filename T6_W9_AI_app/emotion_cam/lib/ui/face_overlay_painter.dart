import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/face_result.dart';

class FaceOverlayPainter extends CustomPainter {
  FaceOverlayPainter({
    required this.imageSize,
    required this.results,
    required this.isFrontCamera,
  });

  final Size? imageSize;
  final List<FaceResult> results;
  final bool isFrontCamera;

  @override
  void paint(Canvas canvas, Size size) {
    if (imageSize == null || results.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.greenAccent;

    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    for (final r in results) {
      final rectInImage = _maybeMirror(r.boundingBox, imageSize!, isFrontCamera);
      final rect = _mapRectCover(rectInImage, imageSize!, size);

      canvas.drawRect(rect, paint);

      final label = '${r.emotion} ${(r.confidence * 100).toStringAsFixed(0)}%';
      final tp = TextPainter(
        text: TextSpan(text: label, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);

      final bgRect = Rect.fromLTWH(
        rect.left,
        (rect.top - tp.height - 6).clamp(0, size.height),
        tp.width + 10,
        tp.height + 6,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(bgRect, const Radius.circular(6)),
        Paint()..color = Colors.black.withOpacity(0.55),
      );

      tp.paint(canvas, Offset(bgRect.left + 5, bgRect.top + 3));
    }
  }

  Rect _maybeMirror(Rect rect, Size imageSize, bool mirror) {
    if (!mirror) return rect;
    return Rect.fromLTWH(
      imageSize.width - rect.left - rect.width,
      rect.top,
      rect.width,
      rect.height,
    );
  }

  /// Maps a rect from image coordinates into widget coordinates when the image
  /// is displayed with BoxFit.cover.
  Rect _mapRectCover(Rect rect, Size imageSize, Size widgetSize) {
    final scale = _coverScale(imageSize, widgetSize);
    final dx = (widgetSize.width - imageSize.width * scale) / 2;
    final dy = (widgetSize.height - imageSize.height * scale) / 2;

    return Rect.fromLTWH(
      rect.left * scale + dx,
      rect.top * scale + dy,
      rect.width * scale,
      rect.height * scale,
    );
  }

  double _coverScale(Size input, Size output) {
    final scaleW = output.width / input.width;
    final scaleH = output.height / input.height;
    return scaleW > scaleH ? scaleW : scaleH;
  }

  @override
  bool shouldRepaint(covariant FaceOverlayPainter oldDelegate) {
    return oldDelegate.results != results ||
        oldDelegate.imageSize != imageSize ||
        oldDelegate.isFrontCamera != isFrontCamera;
  }
}
