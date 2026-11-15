import 'package:flutter/material.dart';
import '../ui/app_theme.dart';

class ResultScreen extends StatelessWidget {
  final double goalLiters;
  final double consumedLiters;

  const ResultScreen({
    super.key,
    required this.goalLiters,
    required this.consumedLiters,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (goalLiters > 0) ? (consumedLiters / goalLiters).clamp(0.0, 1.0) : 0.0;
    final percentage = (progress * 100).toStringAsFixed(0);
    final remaining = (goalLiters - consumedLiters).clamp(0.0, double.infinity);

    String message = '';
    if (progress >= 1.0) {
      message = 'Fantastic, You reached your goal today!';
    } else if (progress >= 0.5) {
      message = 'Good job, You are halfway there! Keep going!';
    } else {
      message = 'You need to drink more water to stay hydrated!';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Report'),
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
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                const Text('Progress Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70)),
                                const SizedBox(height: 20),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      height: 140,
                                      child: CircularProgressIndicator(
                                        value: progress,
                                        strokeWidth: 12,
                                        backgroundColor: Colors.white10,
                                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                                      ),
                                    ),
                                    Text('$percentage%', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.lightBlueAccent)),
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
                                _buildStatRow('Daily Goal', '${goalLiters.toStringAsFixed(1)} L'),
                                const Divider(color: Colors.white10, height: 40),
                                _buildStatRow('Consumed', '${consumedLiters.toStringAsFixed(2)} L'),
                                const Divider(color: Colors.white10, height: 40),
                                _buildStatRow('Remaining', '${remaining.toStringAsFixed(2)} L'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to Tracker', style: TextStyle(fontSize: 16)),
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

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white60)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}
