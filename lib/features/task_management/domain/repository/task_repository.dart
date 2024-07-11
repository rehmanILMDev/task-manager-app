// step 4

import 'package:dartz/dartz.dart' as dartz; 
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';

abstract class TaskRepository {
  Future<dartz.Either<Failure, List<Task>>> getAllTasks(); 
  Future<dartz.Either<Failure, Task>> getTask(String id);
  Future<dartz.Either<Failure, void>> createTask(Task task); 
  Future<dartz.Either<Failure, void>> updateTask(Task task); 
  Future<dartz.Either<Failure, void>> deleteTask(String id);
}
