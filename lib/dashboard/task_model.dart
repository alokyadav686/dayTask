import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> task = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTask();
  }

  Future<void> fetchTask() async {
    final response = await supabase
        .from('tasks')
        .select()
        .eq('is_complete', false)
        .order('due_date', ascending: true);

    setState(() {
      task = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text(
          "Task Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const Text(
              "Real Estate App Design",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(Icons.calendar_today_outlined, "20 June"),
                const SizedBox(width: 12),
                _infoCard(Icons.group_outlined, "Project Team"),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Project Details",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  "Project Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        value: 0.6,
                        color: Colors.yellow,
                        backgroundColor: Colors.white24,
                        strokeWidth: 4,
                      ),
                    ),
                    const Text(
                      "60%",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "All Tasks",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  _taskTile("User Interviews", true),
                  _taskTile("Wireframes", true),
                  _taskTile("Design System", true),
                  _taskTile("Icons", false),
                  _taskTile("Final Mockups", false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF1E2A38),
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to add task page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            "Add Task",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3C4A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.yellow),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _taskTile extends StatelessWidget {
  final String title;
  final bool isChecked;

  const _taskTile(this.title, this.isChecked);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF2D3C4A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: isChecked ? Colors.yellow[700] : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white70),
            ),
            child:
                isChecked
                    ? const Icon(Icons.check, size: 16, color: Colors.black)
                    : null,
          ),
        ],
      ),
    );
  }
}
