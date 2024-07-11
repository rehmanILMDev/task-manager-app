
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_state.dart';

class TaskFormScreen extends StatefulWidget {
  final String? taskId;

  TaskFormScreen({this.taskId});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.taskId != null) {
      context.read<TaskBloc>().add(LoadTask(widget.taskId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskId == null ? 'Create Task' : 'Update Task'),
        actions: [
          if (widget.taskId != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<TaskBloc>().add(DeleteTask(widget.taskId!));
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskDetailLoaded && widget.taskId != null) {
            final task = state.task;
            _titleController.text = task.title;
            _descController.text = task.desc;
            _dateController.text = task.date as String;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                    validator: (value) => value!.isEmpty ? 'Please enter a date' : null,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          id: widget.taskId ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _titleController.text,
                           desc: _descController.text,
                          date: _dateController.text,
                        );
                        if (widget.taskId == null) {
                          context.read<TaskBloc>().add(CreateTask(task));
                        } else {
                          context.read<TaskBloc>().add(UpdateTask(task));
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(widget.taskId == null ? 'Create Task' : 'Update Task'),
                  ),
                ],
              ),
            ),
          );
          
        },
        
      ),
    );

  }
   
}
