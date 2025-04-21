import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime? selectedDate;
  final supabase = Supabase.instance.client;

  Future<void> _addTask() async {
    final title = _titleController.text.trim();
    final details = _detailsController.text.trim();

    if (title.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Title and due date are required")),
      );
      return;
    }

    try {
      final response = await supabase.from('tasks').insert({
        'title': title,
        'details': details,
        'due_date': selectedDate!.toIso8601String(),
        'is_complete': false,
      }).select();

      if (response.isEmpty) {
        throw Exception("Failed to insert task.");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task Added Successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding task")),
      );
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Create New Task', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Task Title"),
            _buildInputField(_titleController, "Enter Title Here"),

            SizedBox(height: 20),
            _buildLabel("Task Details"),
            _buildInputField(
              _detailsController,
              "Description",
              maxLines: 4,
            ),

            SizedBox(height: 20),
            _buildLabel("Add team members"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                
                IconButton(
                  onPressed: () {}, 
                  icon: Icon(Icons.add_box_outlined, color: Colors.white),
                ),
              ],
            ),

            SizedBox(height: 20),
            _buildLabel("Time & Date"),
            Row(
              children: [
                Expanded(
                  child: _buildPickerField(
                    icon: Icons.access_time,
                    label: "10:30 AM", // placeholder only
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildPickerField(
                    icon: Icons.calendar_today,
                    label: selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : "Pick a date",
                    onTap: _selectDate,
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),
            Center(
              child: Text("Add New", style: TextStyle(color: Colors.white54)),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: _addTask,
              child: Text("Create", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildChip(String name) {
    return Chip(
      backgroundColor: Colors.blueGrey.shade600,
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: Icon(Icons.person, size: 16, color: Colors.black),
      ),
      label: Text(name, style: TextStyle(color: Colors.white)),
      deleteIcon: Icon(Icons.close, color: Colors.white),
      onDeleted: () {},
    );
  }

  Widget _buildPickerField({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 20),
            SizedBox(width: 8),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
