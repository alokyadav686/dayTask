import 'package:daytask/constants/color.dart';
import 'package:daytask/dashboard/task_model.dart';
import 'package:daytask/views/home/widget/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final response = await supabase
        .from('tasks')
        .select()
        .eq('is_complete', false)
        .order('due_date', ascending: true);

    setState(() {
      tasks = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Fazil Laghari",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Schyler',
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage("assets/avatar.png"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 58,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(69, 90, 100, 1),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.white60),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search tasks",
                                  hintStyle: TextStyle(color: Colors.white54),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(color: AppColors.buttonColor),
                      child: SvgPicture.asset(
                        "assets/images/menu.svg",
                        color: Colors.black,
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Completed Tasks
                _sectionHeader("Completed Tasks"),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CompletedCard(
                        title: "Real Estate Website Design",
                        color: AppColors.buttonColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Ongoing Projects
                _sectionHeader("Ongoing Projects"),
                const SizedBox(height: 12),
                tasks.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                      children:
                          tasks.map((task) {
                            final dueDate = DateTime.parse(task['due_date']);
                            final formattedDate = DateFormat(
                              'd MMMM',
                            ).format(dueDate);
                            return GestureDetector(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TaskDetailsPage(taskId: task['id']),
    ),
  );
},
                              child: OngoingCard(
                                title: task['title'],
                                dueDate: formattedDate,
                                percent: 0.6, // optionally make dynamic later
                              ),
                            );
                          }).toList(),
                    ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "See all",
          style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// Reusable Card Widgets

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
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
      ),
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
