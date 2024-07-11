import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_state.dart';
import 'package:task_manager/features/task_management/presentation/widget/task_card_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadTasks());

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return TaskCardWidget(task: task);
            },
          );
        } else if (state is TaskError) {
          return Center(child: Text(state.message));
        }
        return const Center(
          child: Text("No Task Available"),
        );
      },
      
    );
  }
}
