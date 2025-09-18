import 'package:intl/intl.dart';

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String priority;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final completion = (json['completion'] ?? '').toString().toLowerCase();

    return TaskModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: _formatPriority(json['priority']),
      dueDate: DateTime.tryParse(json['dueDate'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
      isCompleted: completion == 'completed',
    );
  }

  static String _formatPriority(String? value) {
    switch (value?.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Medium';
    }
  }

  String get dueDateLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final diff = dateOnly.difference(today).inDays;

    if (diff == 0) return 'Today';
    if (diff == -1) return 'Yesterday';
    if (diff == 1) return 'Tomorrow';
    if (diff > 1 && diff <= 7) return 'This week';
    if (diff > 7 && diff <= 14) return 'Next week';

    return DateFormat('dd MMM').format(dueDate);
  }
}
