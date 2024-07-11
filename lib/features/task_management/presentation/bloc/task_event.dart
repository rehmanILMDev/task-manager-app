
import 'package:equatable/equatable.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class LoadTask extends TaskEvent {
  final String id;

  const LoadTask(this.id);

  @override
  List<Object> get props => [id];
}

class CreateTask extends TaskEvent {
  final Task task;

  const CreateTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}
