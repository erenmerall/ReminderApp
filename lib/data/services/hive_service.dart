import 'package:hive/hive.dart';
import '../models/reminder_model.dart';

class HiveService {
  final Box _box = Hive.box('reminders');

  List<ReminderModel> getReminders() {
    return _box.values
        .map((e) => ReminderModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> addReminder(ReminderModel reminder) async {
    await _box.put(reminder.id, reminder.toMap());
  }

  Future<void> deleteReminder(String id) async {
    await _box.delete(id);
  }

  void saveReminder(ReminderModel reminder) {
    final box = Hive.box<ReminderModel>('reminders');
    box.put(reminder.id, reminder);
  }
}
