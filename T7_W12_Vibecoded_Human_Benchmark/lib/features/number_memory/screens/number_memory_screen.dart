import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../shared/services/results_store.dart';
import '../../../shared/theme/neubrutal_theme.dart';

enum _MemoryPhase { idle, showing, input, result }

class NumberMemoryScreen extends StatefulWidget {
  const NumberMemoryScreen({super.key});

  @override
  State<NumberMemoryScreen> createState() => _NumberMemoryScreenState();
}

class _NumberMemoryScreenState extends State<NumberMemoryScreen> {
  static const Duration _showDuration = Duration(seconds: 2);
  final ResultsStore _resultsStore = ResultsStore();
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  _MemoryPhase _phase = _MemoryPhase.idle;
  int _level = 1;
  String _number = '';
  GameStats? _stats;

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startGame() {
    _timer?.cancel();
    _controller.clear();
    setState(() {
      _level = 1;
      _stats = null;
    });
    _showNumber();
  }

  void _showNumber() {
    _timer?.cancel();
    final length = _level + 2;
    final rand = Random();
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(rand.nextInt(10));
    }
    setState(() {
      _number = buffer.toString();
      _phase = _MemoryPhase.showing;
    });
    _timer = Timer(_showDuration, () {
      setState(() {
        _phase = _MemoryPhase.input;
      });
    });
  }

  Future<void> _submit() async {
    if (_phase != _MemoryPhase.input) {
      return;
    }
    final guess = _controller.text.trim();
    _controller.clear();
    if (guess == _number) {
      setState(() {
        _level += 1;
      });
      _showNumber();
      return;
    }
    setState(() {
      _phase = _MemoryPhase.result;
    });
    final stats = await _resultsStore.recordNumberLevel(_level);
    if (!mounted) return;
    setState(() {
      _stats = stats;
    });
  }

  String _comparisonText(GameStats stats) {
    if (stats.count <= 1) {
      return 'First result saved.';
    }
    if (stats.latest == stats.best) {
      return 'New personal best!';
    }
    final delta = stats.best - stats.latest;
    return '${delta.toStringAsFixed(0)} below best.';
  }

  Widget _buildPanel(BuildContext context) {
    switch (_phase) {
      case _MemoryPhase.idle:
        return Text(
          'Press start to begin',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        );
      case _MemoryPhase.showing:
        return Text(
          _number,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        );
      case _MemoryPhase.input:
        return Text(
          'Enter the number',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        );
      case _MemoryPhase.result:
        return Text(
          'Level $_level',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Memory')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: NeubrutalTheme.cardDecoration(
                color: NeubrutalTheme.accent,
              ),
              child: Text('Level $_level'),
            ),
            const SizedBox(height: 18),
            Container(
              height: 220,
              alignment: Alignment.center,
              decoration: NeubrutalTheme.cardDecoration(),
              child: _buildPanel(context),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: NeubrutalTheme.cardDecoration(
                color: NeubrutalTheme.card,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      hintText: 'Your answer',
                      border: OutlineInputBorder(),
                    ),
                    enabled: _phase == _MemoryPhase.input,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed:
                        _phase == _MemoryPhase.idle
                            ? _startGame
                            : (_phase == _MemoryPhase.result
                                ? _startGame
                                : _submit),
                    child: Text(
                      _phase == _MemoryPhase.idle
                          ? 'Start'
                          : (_phase == _MemoryPhase.result
                              ? 'Restart'
                              : 'Submit'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
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
                    Text('Best: ${_stats!.best.toStringAsFixed(0)}'),
                    Text('Average: ${_stats!.average.toStringAsFixed(1)}'),
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
