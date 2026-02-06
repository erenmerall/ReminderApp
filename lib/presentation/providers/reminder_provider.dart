import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../data/models/reminder_model.dart';
import '../../data/services/hive_service.dart';
import 'package:uuid/uuid.dart';
import '../../data/services/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  final Box _box = Hive.box('reminders');

  List<ReminderModel> _reminders = [];

  List<ReminderModel> get reminders => _reminders;
  
  List<ReminderModel> get active =>
      _reminders.where((r) => !r.isCompleted && !r.isDeleted).toList();

  List<ReminderModel> get completed =>
      _reminders.where((r) => r.isCompleted && !r.isDeleted).toList();

  List<ReminderModel> get deleted =>
      _reminders.where((r) => r.isDeleted).toList();

  void init() {
    _reminders = _box.values
        .map((e) => ReminderModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  void addReminder(String title, DateTime dateTime, String category) {
    final reminder = ReminderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      dateTime: dateTime,
      category: category,
    );

    _box.put(reminder.id, reminder.toMap());
    _reminders.add(reminder);

    NotificationService.scheduleNotification(reminder);

    notifyListeners();
  }

  void togglePin(ReminderModel reminder) {
    final updated = ReminderModel(
      id: reminder.id,
      title: reminder.title,
      dateTime: reminder.dateTime,
      category: reminder.category,
      isCompleted: reminder.isCompleted,
      isPinned: !reminder.isPinned,
    );

    _box.put(updated.id, updated.toMap());

    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    _reminders[index] = updated;

    notifyListeners();
  }

  void toggleComplete(ReminderModel r) {
    final updated = ReminderModel(
      id: r.id,
      title: r.title,
      dateTime: r.dateTime,
      category: r.category,
      isCompleted: !r.isCompleted,
      isPinned: r.isPinned,
      isDeleted: false,
    );

    _update(updated);
  }

  void deleteReminder(ReminderModel r) {
    final updated = ReminderModel(
      id: r.id,
      title: r.title,
      dateTime: r.dateTime,
      category: r.category,
      isCompleted: false,
      isPinned: false,
      isDeleted: true,
    );

    _update(updated);
  }

  void _update(ReminderModel updated) {
    _box.put(updated.id, updated.toMap());
    final index = _reminders.indexWhere((e) => e.id == updated.id);
    _reminders[index] = updated;
    notifyListeners();
  }
}
