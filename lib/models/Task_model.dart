import 'package:equatable/equatable.dart';
class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  TaskModel copyWith({String? id, String? title, bool? isCompleted}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
