import 'package:flutter/material.dart';

class ReminderCategory {
  final String name;
  final Color color;
  final IconData icon;

  const ReminderCategory(this.name, this.color, this.icon);
}

const categories = [
  ReminderCategory("Work", Colors.blue, Icons.work),
  ReminderCategory("Personal", Colors.green, Icons.person),
  ReminderCategory("Health", Colors.red, Icons.favorite),
  ReminderCategory("Shopping", Colors.orange, Icons.shopping_cart),
  ReminderCategory("Sports", Colors.yellow, Icons.sports_basketball),
];
