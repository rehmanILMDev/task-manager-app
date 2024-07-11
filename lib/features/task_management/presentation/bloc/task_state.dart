
import 'package:equatable/equatable.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskDetailLoaded extends TaskState {
  final Task task;

  const TaskDetailLoaded(this.task);

  @override
  List<Object> get props => [task];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
