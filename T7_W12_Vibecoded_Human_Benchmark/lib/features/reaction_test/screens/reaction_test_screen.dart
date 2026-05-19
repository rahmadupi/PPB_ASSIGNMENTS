import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../shared/services/results_store.dart';
import '../../../shared/theme/neubrutal_theme.dart';

enum _ReactionPhase { ready, waiting, go, result, tooSoon }

class ReactionTestScreen extends StatefulWidget {
  const ReactionTestScreen({super.key});

  @override
  State<ReactionTestScreen> createState() => _ReactionTestScreenState();
}

class _ReactionTestScreenState extends State<ReactionTestScreen> {
  final ResultsStore _resultsStore = ResultsStore();
  Timer? _timer;
  _ReactionPhase _phase = _ReactionPhase.ready;
  DateTime? _goTime;
  GameStats? _stats;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleTap() {
    switch (_phase) {
      case _ReactionPhase.ready:
        _startWaiting();
        break;
      case _ReactionPhase.waiting:
        _timer?.cancel();
        setState(() {
          _phase = _ReactionPhase.tooSoon;
        });
        break;
      case _ReactionPhase.go:
        _recordReaction();
        break;
      case _ReactionPhase.result:
      case _ReactionPhase.tooSoon:
        _reset();
        break;
    }
  }

  void _startWaiting() {
    _timer?.cancel();
    setState(() {
      _phase = _ReactionPhase.waiting;
      _stats = null;
      _goTime = null;
    });
    final delayMs = 800 + Random().nextInt(1600);
    _timer = Timer(Duration(milliseconds: delayMs), () {
      setState(() {
        _phase = _ReactionPhase.go;
        _goTime = DateTime.now();
      });
    });
  }

  Future<void> _recordReaction() async {
    final start = _goTime;
    if (start == null) {
      return;
    }
    final elapsed = DateTime.now().difference(start).inMilliseconds;
    final stats = await _resultsStore.recordReactionResult(elapsed);
    setState(() {
      _stats = stats;
      _phase = _ReactionPhase.result;
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _phase = _ReactionPhase.ready;
      _stats = null;
      _goTime = null;
    });
  }

  Color _panelColor() {
    switch (_phase) {
      case _ReactionPhase.waiting:
        return NeubrutalTheme.accentThree;
      case _ReactionPhase.go:
        return Colors.greenAccent;
      default:
        return NeubrutalTheme.card;
    }
  }

  String _panelText() {
    switch (_phase) {
      case _ReactionPhase.ready:
        return 'Tap to start';
      case _ReactionPhase.waiting:
        return 'Wait for green...';
      case _ReactionPhase.go:
        return 'Tap!';
      case _ReactionPhase.result:
        return '${_stats?.latest.toStringAsFixed(0) ?? '--'} ms';
      case _ReactionPhase.tooSoon:
        return 'Too soon!';
    }
  }

  String _comparisonText(GameStats stats) {
    if (stats.count <= 1) {
      return 'First result saved.';
    }
    final delta = stats.latest - stats.best;
    if (delta <= 0) {
      return 'New personal best!';
    }
    return '${delta.toStringAsFixed(0)} ms slower than best.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reaction Time')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: NeubrutalTheme.cardDecoration(
                color: NeubrutalTheme.accent,
              ),
              child: Text(
                'Tap to start. Wait for green. Then tap fast.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GestureDetector(
                onTap: _handleTap,
                child: Container(
                  alignment: Alignment.center,
                  decoration: NeubrutalTheme.cardDecoration(
                    color: _panelColor(),
                  ),
                  child: Text(
                    _panelText(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_stats != null)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: NeubrutalTheme.cardDecoration(
                  color: NeubrutalTheme.accentTwo,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _comparisonText(_stats!),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Best: ${_stats!.best.toStringAsFixed(0)} ms'),
                    Text('Average: ${_stats!.average.toStringAsFixed(0)} ms'),
                    Text('Runs: ${_stats!.count}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
