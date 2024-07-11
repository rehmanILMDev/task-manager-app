import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:task_manager/core/error/exceptions.dart';
import 'package:task_manager/core/util/constants.dart';
import 'package:task_manager/features/task_management/data/models/task_model.dart';

class TaskRemoteDataSource {
  final Dio client;

  TaskRemoteDataSource({required this.client});

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final response = await client.get('${Constants.baseUrl}/tasks');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<TaskModel> getTask(String id) async {
    try {
      final response = await client.get('${Constants.baseUrl}/tasks/$id');
      return TaskModel.fromJson(response.data);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> createTask(TaskModel task) async {
    try {
      final response = await client.post(
        '${Constants.baseUrl}/tasks',
        data: json.encode(task.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode != 201) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final response = await client.put(
        '${Constants.baseUrl}/tasks/${task.id}',
        data: json.encode(task.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await client.delete('${Constants.baseUrl}/tasks/$id');
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
