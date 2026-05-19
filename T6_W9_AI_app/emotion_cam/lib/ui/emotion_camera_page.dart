import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/face_result.dart';
import 'face_overlay_painter.dart';

class EmotionCameraPage extends StatefulWidget {
  const EmotionCameraPage({super.key});

  @override
  State<EmotionCameraPage> createState() => _EmotionCameraPageState();
}

class _EmotionCameraPageState extends State<EmotionCameraPage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  late final FaceDetector _faceDetector;

  Timer? _timer;
  bool _busy = false;

  Size? _lastImageSize;
  List<FaceResult> _results = const [];
  bool _isFrontCamera = true;
  bool _hasCameraPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        enableClassification: true,
        enableContours: false,
        enableLandmarks: false,
      ),
    );

    _init();
  }

  Future<void> _init() async {
    final camStatus = await Permission.camera.request();
    _hasCameraPermission = camStatus.isGranted;
    if (mounted) setState(() {});
    if (!_hasCameraPermission) return;

    final cameras = await availableCameras();
    final preferred = cameras.where(
      (c) => c.lensDirection == CameraLensDirection.front,
    );
    final description = preferred.isNotEmpty ? preferred.first : cameras.first;
    _isFrontCamera = description.lensDirection == CameraLensDirection.front;

    final controller = CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller.initialize();

    if (!mounted) {
      await controller.dispose();
      return;
    }

    setState(() {
      _controller = controller;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      unawaited(_tick());
    });
  }

  Future<void> _tick() async {
    final controller = _controller;
    if (controller == null) return;
    if (!controller.value.isInitialized) return;
    if (_busy) return;

    _busy = true;
    try {
      final file = await controller.takePicture();
      final inputImage = InputImage.fromFilePath(file.path);
      final faces = await _faceDetector.processImage(inputImage);

      final preview = controller.value.previewSize;
      // Fallback if previewSize is not available on some devices.
      final imageSize =
          preview == null
              ? const Size(480, 640)
              : Size(preview.height, preview.width);

      if (faces.isEmpty) {
        if (mounted) {
          setState(() {
            _lastImageSize = imageSize;
            _results = const [];
          });
        }
        return;
      }
      final results = <FaceResult>[];

      for (final face in faces) {
        final smile = face.smilingProbability;

        // Fully offline: ML Kit provides a smile probability.
        // We map it to a simple "happy" vs "neutral" emotion.
        String emotion;
        double confidence;
        if (smile == null) {
          emotion = 'unknown';
          confidence = 0.0;
        } else if (smile >= 0.60) {
          emotion = 'happy';
          confidence = smile.clamp(0.0, 1.0);
        } else {
          emotion = 'neutral';
          confidence = (1.0 - smile).clamp(0.0, 1.0);
        }

        results.add(
          FaceResult(
            boundingBox: face.boundingBox,
            emotion: emotion,
            confidence: confidence,
          ),
        );
      }

      if (mounted) {
        setState(() {
          _lastImageSize = imageSize;
          _results = results;
        });
      }

      // Best-effort cleanup.
      unawaited(File(file.path).delete());
    } catch (_) {
      // Keep the UI quiet for a simple demo.
    } finally {
      _busy = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _timer?.cancel();
      unawaited(controller.dispose());
      if (mounted) {
        setState(() {
          _controller = null;
        });
      } else {
        _controller = null;
      }
    } else if (state == AppLifecycleState.resumed) {
      unawaited(_init());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _faceDetector.close();
    unawaited(_controller?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (!_hasCameraPermission) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Camera permission required',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: controller.value.aspectRatio / size.aspectRatio,
            child: Center(child: CameraPreview(controller)),
          ),
          IgnorePointer(
            child: CustomPaint(
              painter: FaceOverlayPainter(
                imageSize: _lastImageSize,
                results: _results,
                isFrontCamera: _isFrontCamera,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
