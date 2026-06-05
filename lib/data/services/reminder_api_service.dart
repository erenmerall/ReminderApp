import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reminder_model.dart';

class ReminderApiService {
  static const baseUrl = "https://localhost:5001/api/reminders";

  Future<List<ReminderModel>> fetchReminders() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => ReminderModel.fromMap(e)).toList();
    } else {
      throw Exception("Failed to load reminders");
    }
  }

  Future<void> createReminder(ReminderModel reminder) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(reminder.toMap()),
    );
  }
}
