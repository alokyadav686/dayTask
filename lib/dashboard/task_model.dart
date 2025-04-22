import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskDetailsPage extends StatefulWidget {
  final int taskId;

  const TaskDetailsPage({super.key, required this.taskId});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? task;

  @override
  void initState() {
    super.initState();
    fetchTask();
  }

  Future<void> fetchTask() async {
    final response =
        await supabase.from('tasks').select().eq('id', widget.taskId).single();

    setState(() {
      task = Map<String, dynamic>.from(response);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFF1E2A38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text(
                      "Options",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.edit, color: Colors.yellow),
                          title: const Text(
                            "Edit Task",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            final titleController = TextEditingController(
                              text: task!['title'],
                            );
                            final detailsController = TextEditingController(
                              text: task!['details'],
                            );

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: const Color(0xFF1E2A38),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                    left: 20,
                                    right: 20,
                                    top: 20,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Edit Task",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        controller: titleController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: const InputDecoration(
                                          labelText: 'Title',
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white38,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: detailsController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: const InputDecoration(
                                          labelText: 'Details',
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white38,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final updatedTitle =
                                              titleController.text.trim();
                                          final updatedDetails =
                                              detailsController.text.trim();

                                          if (updatedTitle.isEmpty) return;

                                          await supabase
                                              .from('tasks')
                                              .update({
                                                'title': updatedTitle,
                                                'details': updatedDetails,
                                              })
                                              .eq('id', widget.taskId);

                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            fetchTask();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow[700],
                                        ),
                                        child: const Text(
                                          "Save Changes",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          title: const Text(
                            "Delete Task",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () async {
                            Navigator.pop(
                              context,
                            ); // Close the options dialog first

                            final confirm = await showDialog<bool>(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: const Text("Are you sure?"),
                                    content: const Text(
                                      "This task will be deleted permanently.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(ctx).pop(false),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(ctx).pop(true),
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                            );

                            if (confirm == true) {
                              await supabase
                                  .from('tasks')
                                  .delete()
                                  .eq('id', widget.taskId);

                              if (mounted) {
                                Navigator.of(
                                  context,
                                ).pop(); // ✅ Pop TaskDetailsPage!
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      body:
          task == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      task!['title'] ?? "Task Title",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Schyler',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _infoCard(
                          Icons.calendar_today_outlined,
                          DateFormat(
                            'd MMMM',
                          ).format(DateTime.parse(task!['due_date'])),
                        ),
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
                    Text(
                      task!['details'] ?? "No details available",
                      style: const TextStyle(color: Colors.white70),
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
                                value:
                                    0.6, 
                                color: AppColors.buttonColor,
                                backgroundColor: Colors.white24,
                                strokeWidth: 4,
                              ),
                            ),
                            const Text(
                              "60%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
        color: AppColors.primaryColor,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to add task page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            shape: RoundedRectangleBorder(),
            minimumSize: const Size(double.infinity, 55),
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
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.buttonColor),
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
        color: AppColors.lightBlue,
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
          const Spacer(),
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.buttonColor : Colors.transparent,
              borderRadius: BorderRadius.circular(0),
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
