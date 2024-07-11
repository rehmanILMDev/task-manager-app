
import 'package:dartz/dartz.dart' as dartz; 
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/features/task_management/domain/repository/task_repository.dart';

class GetTask {
  final TaskRepository repository;

  GetTask(this.repository);

  Future<dartz.Either<Failure, Task>> call(String id) async {
    return await repository.getTask(id);
  }
}
