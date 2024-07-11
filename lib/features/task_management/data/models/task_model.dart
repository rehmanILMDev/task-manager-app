// step 2

import 'package:task_manager/features/task_management/domain/entities/task.dart';

class TaskModel {
  final String id;
  final String title;
  final String desc;
  final String date;

  TaskModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    // final dateFormat = DateFormat('dd/MM/yyyy');
    return TaskModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
    };
  }

  Task toDomain() {
    return Task(
      id: id,
      title: title,
      desc: desc,
      date: date,
    );
  }
}
