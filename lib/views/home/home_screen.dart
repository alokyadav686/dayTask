import 'package:daytask/dashboard/task_detail.dart';
import 'package:daytask/views/home/widget/completed_card.dart';
import 'package:daytask/views/home/widget/ongoing_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:daytask/constants/color.dart';
import 'package:daytask/views/home/widget/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;

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
                            builder: (context) =>  ProfileScreen(),
                          ),
                        );
                      },
                      child: const CircleAvatar(
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
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(69, 90, 100, 1),
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
                      decoration:
                          const BoxDecoration(color: AppColors.buttonColor),
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
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: supabase
                      .from('tasks')
                      .stream(primaryKey: ['id'])
                      .eq('is_complete', false)
                      .order('due_date', ascending: true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No ongoing tasks.'));
                    } else {
                      final tasks = snapshot.data!;
                      return Column(
                        children: tasks.map((task) {
                          final dueDate = DateTime.parse(task['due_date']);
                          final formattedDate =
                              DateFormat('d MMMM').format(dueDate);
                          return FutureBuilder<double>(
                            future: _calculateProgress(task['id']),
                            builder: (context, progressSnapshot) {
                              final progress = progressSnapshot.data ?? 0.0;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TaskDetailsPage(taskId: task['id']),
                                    ),
                                  );
                                },
                                child: OngoingCard(
                                  title: task['title'],
                                  dueDate: formattedDate,
                                  percent: progress,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                  },
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
          style: TextStyle(
            color: AppColors.buttonColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Future<double> _calculateProgress(int taskId) async {
    final subtasks = await supabase
        .from('subtasks')
        .select()
        .eq('task_id', taskId);

    if (subtasks.isEmpty) return 0.0;

    final completed = subtasks.where((s) => s['is_complete'] == true).length;
    return completed / subtasks.length;
  }
}
