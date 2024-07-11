// step 3.1 


import 'package:task_manager/features/task_management/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTask(String id);
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final List<TaskModel> _tasks = [];

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return _tasks;
  }

  @override
  Future<TaskModel> getTask(String id) async {
    return _tasks.firstWhere((task) => task.id == id);
  }

  @override
  Future<void> createTask(TaskModel task) async {
    _tasks.add(task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
