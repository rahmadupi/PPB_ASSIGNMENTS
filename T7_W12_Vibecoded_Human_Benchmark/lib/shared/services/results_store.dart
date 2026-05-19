import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class GameStats {
  const GameStats({
    required this.latest,
    required this.best,
    required this.average,
    required this.count,
  });

  final double latest;
  final double best;
  final double average;
  final int count;
}

class ResultsStore {
  static const String _reactionKey = 'reaction_results_ms';
  static const String _mathKey = 'math_speed_scores';
  static const String _numberKey = 'number_memory_levels';

  Future<GameStats> recordReactionResult(int milliseconds) async {
    return _recordResult(
      key: _reactionKey,
      value: milliseconds.toDouble(),
      lowerIsBetter: true,
    );
  }

  Future<GameStats> recordMathScore(int score) async {
    return _recordResult(
      key: _mathKey,
      value: score.toDouble(),
      lowerIsBetter: false,
    );
  }

  Future<GameStats> recordNumberLevel(int level) async {
    return _recordResult(
      key: _numberKey,
      value: level.toDouble(),
      lowerIsBetter: false,
    );
  }

  Future<GameStats?> getReactionStats() async {
    return _readStats(_reactionKey, lowerIsBetter: true);
  }

  Future<GameStats?> getMathStats() async {
    return _readStats(_mathKey, lowerIsBetter: false);
  }

  Future<GameStats?> getNumberStats() async {
    return _readStats(_numberKey, lowerIsBetter: false);
  }

  Future<GameStats?> _readStats(
    String key, {
    required bool lowerIsBetter,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(key) ?? const <String>[];
    if (items.isEmpty) {
      return null;
    }
    final values =
        items
            .map((value) => double.tryParse(value))
            .whereType<double>()
            .toList();
    if (values.isEmpty) {
      return null;
    }
    final latest = values.last;
    final best = lowerIsBetter ? values.reduce(min) : values.reduce(max);
    final average = values.reduce((a, b) => a + b) / values.length;
    return GameStats(
      latest: latest,
      best: best,
      average: average,
      count: values.length,
    );
  }

  Future<GameStats> _recordResult({
    required String key,
    required double value,
    required bool lowerIsBetter,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(key) ?? <String>[];
    items.add(value.toString());
    await prefs.setStringList(key, items);

    final values =
        items.map((item) => double.tryParse(item)).whereType<double>().toList();
    final best = lowerIsBetter ? values.reduce(min) : values.reduce(max);
    final average = values.reduce((a, b) => a + b) / values.length;

    return GameStats(
      latest: value,
      best: best,
      average: average,
      count: values.length,
    );
  }
}
