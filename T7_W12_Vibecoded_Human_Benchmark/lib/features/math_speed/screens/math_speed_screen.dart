import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../shared/services/results_store.dart';
import '../../../shared/theme/neubrutal_theme.dart';

class MathSpeedScreen extends StatefulWidget {
  const MathSpeedScreen({super.key});

  @override
  State<MathSpeedScreen> createState() => _MathSpeedScreenState();
}

class _MathSpeedScreenState extends State<MathSpeedScreen> {
  static const int _roundSeconds = 30;
  final ResultsStore _resultsStore = ResultsStore();
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _timeLeft = _roundSeconds;
  int _score = 0;
  int _a = 0;
  int _b = 0;
  String _op = '+';
  bool _isRunning = false;
  bool _isOver = false;
  GameStats? _stats;

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startGame() {
    _timer?.cancel();
    setState(() {
      _timeLeft = _roundSeconds;
      _score = 0;
      _isRunning = true;
      _isOver = false;
      _stats = null;
    });
    _nextQuestion();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft <= 1) {
        timer.cancel();
        _finishGame();
        return;
      }
      setState(() {
        _timeLeft -= 1;
      });
    });
  }

  Future<void> _finishGame() async {
    setState(() {
      _isRunning = false;
      _isOver = true;
    });
    final stats = await _resultsStore.recordMathScore(_score);
    if (!mounted) return;
    setState(() {
      _stats = stats;
    });
  }

  void _nextQuestion() {
    final rand = Random();
    final useAdd = rand.nextBool();
    var left = rand.nextInt(20) + 1;
    var right = rand.nextInt(20) + 1;
    if (!useAdd && right > left) {
      final temp = left;
      left = right;
      right = temp;
    }
    setState(() {
      _a = left;
      _b = right;
      _op = useAdd ? '+' : '-';
    });
  }

  void _submitAnswer() {
    if (!_isRunning) {
      return;
    }
    final input = int.tryParse(_controller.text.trim());
    _controller.clear();
    final answer = _op == '+' ? _a + _b : _a - _b;
    if (input == answer) {
      setState(() {
        _score += 1;
      });
    }
    _nextQuestion();
  }

  String _comparisonText(GameStats stats) {
    if (stats.count <= 1) {
      return 'First result saved.';
    }
    if (stats.latest == stats.best) {
      return 'Matched your personal best!';
    }
    final delta = stats.best - stats.latest;
    return '${delta.toStringAsFixed(0)} below best.';
  }

  @override
  Widget build(BuildContext context) {
    final isReady = !_isRunning && !_isOver;
    return Scaffold(
      appBar: AppBar(title: const Text('Math Speed')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: NeubrutalTheme.cardDecoration(
                      color: NeubrutalTheme.accentTwo,
                    ),
                    child: Text('Time: $_timeLeft s'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: NeubrutalTheme.cardDecoration(
                      color: NeubrutalTheme.accentThree,
                    ),
                    child: Text('Score: $_score'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: NeubrutalTheme.cardDecoration(),
              child: Text(
                _isRunning ? '$_a $_op $_b = ?' : 'Press start to begin',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
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
                    onSubmitted: (_) => _submitAnswer(),
                    decoration: const InputDecoration(
                      hintText: 'Type answer',
                      border: OutlineInputBorder(),
                    ),
                    enabled: _isRunning,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _isRunning ? _submitAnswer : _startGame,
                    child: Text(_isRunning ? 'Submit' : 'Start'),
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
            if (isReady)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Answer as many as you can in 30 seconds.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
