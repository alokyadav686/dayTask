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
  List<Map<String, dynamic>> subtasks = [];

  @override
  void initState() {
    super.initState();
    fetchTask();
    fetchSubtasks();
  }

  Future<void> fetchTask() async {
    final response =
        await supabase.from('tasks').select().eq('id', widget.taskId).single();

    setState(() {
      task = Map<String, dynamic>.from(response);
    });
  }

  Future<void> fetchSubtasks() async {
    final response = await supabase
        .from('subtasks')
        .select()
        .eq('task_id', widget.taskId);

    setState(() {
      subtasks = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> addSubtask(String title) async {
    await supabase.from('subtasks').insert({
      'task_id': widget.taskId,
      'title': title,
      'is_complete': false,
    });

    fetchSubtasks(); // Refresh list
  }

  Future<void> toggleSubtaskStatus(int id, bool isComplete) async {
    await supabase
        .from('subtasks')
        .update({'is_complete': !isComplete})
        .eq('id', id);

    fetchSubtasks(); // Refresh list
  }

  double calculateProgress() {
    if (subtasks.isEmpty) return 0.0;
    int completedSubtasks =
        subtasks.where((subtask) => subtask['is_complete']).length;
    return completedSubtasks / subtasks.length;
  }

  void _showAddSubtaskBottomSheet() {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter subtask title',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    addSubtask(controller.text.trim());
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Add Subtask",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                                Navigator.of(context).pop();
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
                    const Text(
                      "Project Progress",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: calculateProgress(),
                            color: AppColors.buttonColor,
                            backgroundColor: Colors.white24,
                            strokeWidth: 4,
                          ),
                        ),
                        Text(
                          '${(calculateProgress() * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
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
                      child: ListView.builder(
                        itemCount: subtasks.length,
                        itemBuilder: (context, index) {
                          final subtask = subtasks[index];
                          return _taskTile(
                            subtask['title'],
                            subtask['is_complete'],
                            () => toggleSubtaskStatus(
                              subtask['id'],
                              subtask['is_complete'],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      bottomNavigationBar: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _showAddSubtaskBottomSheet,
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

  Widget _taskTile(String title, bool isChecked, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 50,
        decoration: BoxDecoration(color: AppColors.lightBlue),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
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
      ),
    );
  }
}
