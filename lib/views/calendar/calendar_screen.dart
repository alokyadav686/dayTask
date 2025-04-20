import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int selectedDateIndex = 3; // 4th (Thu)

  final List<Map<String, String>> dates = [
    {"day": "1", "label": "Mon"},
    {"day": "2", "label": "Tue"},
    {"day": "3", "label": "Wed"},
    {"day": "4", "label": "Thu"},
    {"day": "5", "label": "Fri"},
    {"day": "6", "label": "Sat"},
    {"day": "7", "label": "Sun"},
  ];

  final List<Map<String, dynamic>> tasks = [
    {
      "title": "User Interviews",
      "time": "16:00 - 18:30",
      "highlight": true,
      "avatars": ["avatar1.png", "avatar2.png", "avatar3.png"]
    },
    {
      "title": "Wireframe",
      "time": "16:00 - 18:30",
      "highlight": false,
      "avatars": ["avatar2.png", "avatar3.png", "avatar4.png"]
    },
    {
      "title": "Icons",
      "time": "16:00 - 18:30",
      "highlight": false,
      "avatars": ["avatar5.png"]
    },
    {
      "title": "Mockups",
      "time": "16:00 - 18:30",
      "highlight": false,
      "avatars": ["avatar1.png", "avatar2.png", "avatar3.png"]
    },
    {
      "title": "Testing",
      "time": "16:00 - 18:30",
      "highlight": false,
      "avatars": ["avatar4.png", "avatar5.png"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text("Schedule", style: TextStyle(color: Colors.white)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("November",
                style: TextStyle(color: Colors.white70, fontSize: 16)),

            const SizedBox(height: 12),

            // Date Selector
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      width: 48,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.buttonColor : const Color.fromRGBO(38, 50, 56, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(dates[index]["day"]!,
                              style: TextStyle(
                                  color: isSelected ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(dates[index]["label"]!,
                              style: TextStyle(
                                  color: isSelected ? Colors.black : Colors.white70,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Text("Today's Tasks",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Task Cards
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final isHighlight = task["highlight"] as bool;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isHighlight ? AppColors.buttonColor : Color.fromRGBO(38, 50, 56, 1),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        task["title"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isHighlight ? Colors.black : Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        task["time"],
                        style: TextStyle(
                          color: isHighlight ? Colors.black87 : Colors.white70,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: (task["avatars"] as List<String>).map((avatar) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundImage: AssetImage("assets/avatars/$avatar"),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
