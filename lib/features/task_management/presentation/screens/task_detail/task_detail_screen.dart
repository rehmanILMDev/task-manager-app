import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_state.dart';

class TaskDetailScreen extends StatelessWidget {
  final String id;

  const TaskDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadTask(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RoutesName.taskFormScreen,
                arguments: {'taskId': id},
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTask(id));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskDetailLoaded) {
            final task = state.task;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${task.title}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 8.0),
                  Text('Description: ${task.desc}',
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 8.0),
                  Text('Date: ${task.date}',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
