// step 6

import 'package:dartz/dartz.dart' as dartz; // Aliased import for dartz
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/features/task_management/domain/repository/task_repository.dart';

class GetAllTasks {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  Future<dartz.Either<Failure, List<Task>>> call() async {
    return await repository.getAllTasks();
  }
}

