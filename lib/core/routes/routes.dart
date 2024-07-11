import 'package:flutter/material.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import '../../features/task_management/presentation/screens/screens.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RoutesName.taskFormScreen:
         final args = settings.arguments as Map<String, dynamic>?;
        final taskId = args?['taskId'] as String?;
        return MaterialPageRoute(
          builder: (_) => TaskFormScreen(taskId: taskId),
        );

    case RoutesName.taskDetailScreen:
         final args = settings.arguments as Map<String, dynamic>?;
        final id = args?['id'] as String;
        return MaterialPageRoute(
          builder: (_) => TaskDetailScreen(id: id,),
        );

      case RoutesName.taskListScreen:
        return MaterialPageRoute(builder: (context) => const TaskListScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(body: Center(child: Text('no screen found')));
        });
    }
  }
}
