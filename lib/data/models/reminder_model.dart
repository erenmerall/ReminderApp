class ReminderModel {
  final String id;
  final String title;
  final DateTime dateTime;
  final String category;
  final bool isCompleted;
  final bool isPinned;
  final bool isDeleted;

  ReminderModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.category,
    this.isCompleted = false,
    this.isPinned = false,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'category': category,
      'isCompleted': isCompleted,
      'isPinned': isPinned,
      'isDeleted': isDeleted,
    };
  }

  factory ReminderModel.fromMap(Map map) {
    return ReminderModel(
      id: map['id'],
      title: map['title'],
      dateTime: DateTime.parse(map['dateTime']),
      category: map['category'] ?? "Personal",
      isCompleted: map['isCompleted'] ?? false,
      isPinned: map['isPinned'] ?? false,
    );
  }
}
