import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task_management/presentation/screens/task_list/task_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Task Management'),
          backgroundColor: Theme.of(context).primaryColor),
      body: const TaskListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, RoutesName.taskFormScreen);

          if (result == true) {
            context.read<TaskBloc>().add(LoadTasks());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
