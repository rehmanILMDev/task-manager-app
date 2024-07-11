import 'package:dartz/dartz.dart' as dartz;
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/data/data_sources/task_local_data_source.dart';
import 'package:task_manager/features/task_management/data/data_sources/task_remote_data_source.dart';
import 'package:task_manager/features/task_management/data/models/task_model.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart' as domain;
import 'package:task_manager/features/task_management/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<dartz.Either<Failure, List<domain.Task>>> getAllTasks() async {
    try {
      final remoteTasks = await remoteDataSource.getAllTasks();
      return dartz.Right(remoteTasks.map((model) => model.toDomain()).toList());
    } catch (e, stacktrace) {
      print('Error fetching all tasks: $e');
      print(stacktrace);
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, domain.Task>> getTask(String id) async {
    try {
      final remoteTask = await remoteDataSource.getTask(id);
      return dartz.Right(remoteTask.toDomain());
    } catch (e, stacktrace) {
      print('Error fetching task with id $id: $e');
      print(stacktrace);
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, void>> createTask(domain.Task task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        desc: task.desc,
        date: task.date,
      );
      await remoteDataSource.createTask(taskModel);
      return dartz.Right(null);
    } catch (e, stacktrace) {
      print('Error creating task: $e');
      print(stacktrace);
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, void>> updateTask(domain.Task task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        desc: task.desc,
        date: task.date,
      );
      await remoteDataSource.updateTask(taskModel);
      return dartz.Right(null);
    } catch (e, stacktrace) {
      print('Error updating task: $e');
      print(stacktrace);
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, void>> deleteTask(String id) async {
    try {
      await remoteDataSource.deleteTask(id);
      return dartz.Right(null);
    } catch (e, stacktrace) {
      print('Error deleting task with id $id: $e');
      print(stacktrace);
      return dartz.Left(ServerFailure());
    }
  }
}

extension on TaskModel {
  domain.Task toDomain() {
    return domain.Task(
      id: this.id,
      title: this.title,
      desc: this.desc,
      date: this.date,
    );
  }
}
