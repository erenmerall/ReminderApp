import 'package:flutter/material.dart';

class ReminderTitleTextField extends StatelessWidget {
  const ReminderTitleTextField({super.key, required this.titleController});

  final TextEditingController titleController;
  final String hintText = "Reminder title...";

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}