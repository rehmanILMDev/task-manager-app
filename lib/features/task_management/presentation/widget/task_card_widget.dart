import 'package:flutter/material.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/features/task_management/presentation/screens/task_detail/task_detail_screen.dart';

class TaskCardWidget extends StatelessWidget {
  final Task task;

  TaskCardWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.desc),
        trailing: Text(task.date),
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutesName.taskDetailScreen,
            arguments: {'id': task.id},
          );
        },
      ),
    );
  }
}
