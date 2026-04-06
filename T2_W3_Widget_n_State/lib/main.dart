import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Category { food, scenery, people }

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 4;
  Category? _selected;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _select(Category category) {
    setState(() {
      _selected = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My First App'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade200,
      ),
      backgroundColor: const Color(0xFFF3ECFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ImagePanel(),
              const SizedBox(height: 16),
              const QuestionCard(text: 'What image is that'),
              const SizedBox(height: 16),
              CategoryRow(selected: _selected, onSelected: _select),
              const SizedBox(height: 16),
              CounterPanel(counter: _counter, onIncrement: _incrementCounter),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        border: Border.all(color: Colors.lightBlue.shade200, width: 8),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: const AspectRatio(
          aspectRatio: 1,
          child: Center(child: FlutterLogo(size: 180)),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      color: Colors.pink.shade200,
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }
}

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final Category? selected;
  final ValueChanged<Category> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Colors.amber.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CategoryButton(
            icon: Icons.home,
            label: 'Food',
            isSelected: selected == Category.food,
            onTap: () => onSelected(Category.food),
          ),
          CategoryButton(
            icon: Icons.landscape,
            label: 'Scenery',
            isSelected: selected == Category.scenery,
            onTap: () => onSelected(Category.scenery),
          ),
          CategoryButton(
            icon: Icons.people,
            label: 'People',
            isSelected: selected == Category.people,
            onTap: () => onSelected(Category.people),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isSelected ? Colors.black : Colors.black54;
    final FontWeight fontWeight =
        isSelected ? FontWeight.w700 : FontWeight.w500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: iconColor, fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterPanel extends StatelessWidget {
  const CounterPanel({
    super.key,
    required this.counter,
    required this.onIncrement,
  });

  final int counter;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      color: Colors.lightBlue.shade100,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Counter here: $counter',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: Container(
              width: 56,
              height: 56,
              color: Colors.lightBlue.shade200,
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
