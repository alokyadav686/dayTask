
import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OngoingCard extends StatelessWidget {
  final String title;
  final String dueDate;
  final double percent;

  const OngoingCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.lightBlue),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Team members",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    CircleAvatar(radius: 10, backgroundColor: Colors.white),
                    SizedBox(width: 4),
                    CircleAvatar(radius: 10, backgroundColor: Colors.white),
                    SizedBox(width: 4),
                    CircleAvatar(radius: 10, backgroundColor: Colors.white),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Due on : $dueDate",
                  style: const TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 30,
            lineWidth: 6,
            percent: percent,
            center: Text(
              "${(percent * 100).toInt()}%",
              style: const TextStyle(color: Colors.white),
            ),
            progressColor: Colors.amber,
            backgroundColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}
