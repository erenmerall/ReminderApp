import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/categories.dart';
import '../../data/models/reminder_model.dart';
import '../providers/reminder_provider.dart';

class ReminderCard extends StatelessWidget {
  final ReminderModel reminder;
  final ReminderCategory category;
  final VoidCallback onPin;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.category,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: category.color, width: 1.5),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(category.icon, color: category.color),
                // const Spacer(),
                Text(
                  reminder.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${reminder.dateTime.day}/${reminder.dateTime.month}/${reminder.dateTime.year}",
                ),
              ],
            ),
          ),
          Positioned(
            left: 6,
            bottom: 6,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    reminder.isCompleted
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                  ),
                  onPressed: () =>
                      context.read<ReminderProvider>().toggleComplete(reminder),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () =>
                      context.read<ReminderProvider>().deleteReminder(reminder),
                ),
              ],
            ),
          ),
          Positioned(
            right: 6,
            bottom: 6,
            child: GestureDetector(
              onTap: () {
                context.read<ReminderProvider>().togglePin(reminder);
              },
              child: Icon(
                reminder.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                color: reminder.isPinned ? Colors.orange : Colors.grey,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
