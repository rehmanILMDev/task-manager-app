import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/features/task_management/domain/usecases/create_task.dart' as create_task;
import 'package:task_manager/features/task_management/domain/usecases/delete_task.dart' as delete_task;
import 'package:task_manager/features/task_management/domain/usecases/get_all_tasks.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/update_task.dart' as update_task;
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasks getAllTasks;
  final GetTask getTask;
  final create_task.CreateTask createTask;
  final update_task.UpdateTask updateTask;
  final delete_task.DeleteTask deleteTask;

  TaskBloc({
    required this.getAllTasks,
    required this.getTask,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      final dartz.Either<Failure, List<Task>> failureOrTasks = (await getAllTasks()) as dartz.Either<Failure, List<Task>>;
      emit(failureOrTasks.fold(
        (failure) => TaskError(_mapFailureToMessage(failure)),
        (tasks) => TaskLoaded(tasks),
      ));
    });

    on<LoadTask>((event, emit) async {
      emit(TaskLoading());
      final dartz.Either<Failure, Task> failureOrTask = (await getTask(event.id)) as dartz.Either<Failure, Task>;
      emit(failureOrTask.fold(
        (failure) => TaskError(_mapFailureToMessage(failure)),
        (task) => TaskDetailLoaded(task),
      ));
    });

    on<CreateTask>((event, emit) async {
      final dartz.Either<Failure, void> failureOrSuccess = await createTask(event.task as Task);
      emit(failureOrSuccess.fold(
        (failure) => TaskError(_mapFailureToMessage(failure)),
        (_) async {
          await _refreshTasks(emit);
          return TaskInitial();
        } as TaskState Function(void r),
      ));
    });

    on<UpdateTask>((event, emit) async {
      final dartz.Either<Failure, void> failureOrSuccess = await updateTask(event.task as Task);
      emit(failureOrSuccess.fold(
        (failure) => TaskError(_mapFailureToMessage(failure)),
        (_) async {
          await _refreshTasks(emit);
          return TaskInitial();
        } as TaskState Function(void r),
      ));
    });

    on<DeleteTask>((event, emit) async {
      final dartz.Either<Failure, void> failureOrSuccess = await deleteTask(event.id);
      emit(failureOrSuccess.fold(
        (failure) => TaskError(_mapFailureToMessage(failure)),
        (_) async {
          await _refreshTasks(emit);
          return TaskInitial();
        } as TaskState Function(void r),
      ));
    });
  }

  Future<void> _refreshTasks(Emitter<TaskState> emit) async {
    final dartz.Either<Failure, List<Task>> failureOrTasks = (await getAllTasks()) as dartz.Either<Failure, List<Task>>;
    emit(failureOrTasks.fold(
      (failure) => TaskError(_mapFailureToMessage(failure)),
      (tasks) => TaskLoaded(tasks),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
