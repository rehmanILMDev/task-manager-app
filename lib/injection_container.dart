
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/features/task_management/data/data_sources/task_local_data_source.dart';
import 'package:task_manager/features/task_management/data/data_sources/task_remote_data_source.dart';
import 'package:task_manager/features/task_management/data/repository/task_repository_impl.dart';
import 'package:task_manager/features/task_management/domain/repository/task_repository.dart';
import 'package:task_manager/features/task_management/domain/usecases/create_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/delete_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_all_tasks.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/update_task.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => TaskBloc(
        getAllTasks: sl(),
        getTask: sl(),
        createTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetAllTasks(sl()));
  sl.registerLazySingleton(() => GetTask(sl()));
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSource(client: sl()));
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl());


  // Register Dio
  sl.registerLazySingleton(() => Dio());

}
