
import 'package:flutter/material.dart';

class CompletedCard extends StatelessWidget {
  final String title;
  final Color color;

  const CompletedCard({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Text("Team members", style: TextStyle(color: Colors.black87)),
          Row(
            children: const [
              CircleAvatar(radius: 10, backgroundColor: Colors.white),
              SizedBox(width: 4),
              CircleAvatar(radius: 10, backgroundColor: Colors.white),
              SizedBox(width: 4),
              CircleAvatar(radius: 10, backgroundColor: Colors.white),
            ],
          ),
          const SizedBox(height: 2),
          const Text("Completed"),
          const Text("100%", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
