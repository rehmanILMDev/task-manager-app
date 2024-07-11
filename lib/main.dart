import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/routes/routes.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/themes/theme.dart';
import 'package:task_manager/injection_container.dart' as di;
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<TaskBloc>(),
        ),
      ],
      child: MaterialApp(
          theme: myTheme,
          title: 'Task Management App',
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
          ),
    );
  }
}
