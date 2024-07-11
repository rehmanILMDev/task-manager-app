
import 'package:dartz/dartz.dart' as dartz;
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/features/task_management/domain/repository/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<dartz.Either<Failure, void>> call(Task task) async {
    return await repository.updateTask(task);
  }
}
