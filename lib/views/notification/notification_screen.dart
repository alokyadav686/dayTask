import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            height: 1.375, 
            letterSpacing: 0.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500, 
                fontSize: 20, 
                height: 1.375, 
                letterSpacing: 0.0, 
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            _notificationTile(
              'Olivia Anna',
              'left a comment in task',
              'Mobile App Design Project',
              'assets/avatar1.png',
              '31 min',
            ),
            _notificationTile(
              'Robert Brown',
              'left a comment in task',
              'Mobile App Design Project',
              'assets/avatar2.png',
              '31 min',
            ),
            _notificationTile(
              'Sophia',
              'left a comment in task',
              'Mobile App Design Project',
              'assets/avatar3.png',
              '31 min',
            ),
            _notificationTile(
              'Anna',
              'left a comment in task',
              'Mobile App Design Project',
              'assets/avatar4.png',
              '31 min',
            ),
            const SizedBox(height: 20),
            const Text(
              'Earlier',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _notificationTile(
              'Robert Brown',
              'marked the task',
              'Mobile App Design Project as in process',
              'assets/avatar2.png',
              '4 hours',
            ),
            _notificationTile(
              'Sophia',
              'left a comment in task',
              'Mobile App Design Project',
              'assets/avatar3.png',
              '31 min',
            ),
            _notificationTile(
              'Anna',
              'left a comment in task',
              'Mobile App Design Project',
              'assets/avatar4.png',
              '31 min',
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile(
    String name,
    String action,
    String task,
    String avatarPath,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatarPath)),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$name ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextSpan(
                    text: '$action ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextSpan(
                    text: '\n$task', 
                    style: const TextStyle(
                      color: Colors.amber,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
