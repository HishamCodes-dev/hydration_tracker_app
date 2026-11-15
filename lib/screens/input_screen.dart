import 'package:flutter/material.dart';
import '../ui/app_theme.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  double _goalLiters = 2.0;
  double _consumedLiters = 0.0;

  void _addWater(double amount) {
    setState(() {
      _consumedLiters = (_consumedLiters + amount).clamp(0.0, 10.0);
    });
  }

  void _resetWater() {
    setState(() {
      _consumedLiters = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_goalLiters > 0) ? (_consumedLiters / _goalLiters).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Tracker'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Card(
                          color: AppTheme.cardBg,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              children: [
                                const Text('Daily Goal', style: TextStyle(fontSize: 20, color: Colors.white)),
                                const SizedBox(height: 8),
                                Text('${_goalLiters.toStringAsFixed(1)} Liters', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                                Slider(
                                  value: _goalLiters,
                                  min: 1.0,
                                  max: 10.0,
                                  divisions: 18,
                                  label: '${_goalLiters.toStringAsFixed(1)} L',
                                  onChanged: (value) {
                                    setState(() {
                                      _goalLiters = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          color: AppTheme.cardBg,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Text('Water Consumed', style: TextStyle(fontSize: 20, color: Colors.white)),
                                const SizedBox(height: 8),
                                Text('${_consumedLiters.toStringAsFixed(2)} L', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)),
                                const SizedBox(height: 12),
                                LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () => _addWater(0.25),
                                      icon: const Icon(Icons.add),
                                      label: const Text('0.25L'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () => _addWater(0.5),
                                      icon: const Icon(Icons.add),
                                      label: const Text('0.5L'),
                                    ),
                                    IconButton(
                                      onPressed: _resetWater,
                                      icon: const Icon(Icons.refresh, color: Colors.redAccent),
                                      tooltip: 'Reset',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              goalLiters: _goalLiters,
                              consumedLiters: _consumedLiters,
                            ),
                          ),
                        );
                      },
                      child: const Text('View Report & Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
