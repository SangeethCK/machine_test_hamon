import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/home/bloc/home_bloc.dart';
import 'package:machine_test/applications/registration/registration_bloc.dart';
import 'package:machine_test/applications/students/students_bloc.dart';
import 'package:machine_test/applications/subject/subject_bloc.dart';
import 'package:machine_test/domain/routes/route_generator.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/presentations/screens/home/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
          ),
          BlocProvider<StudentsBloc>(
            create: (context) => StudentsBloc(),
          ),
          BlocProvider<SubjectBloc>(
            create: (context) => SubjectBloc(),
          ),
          BlocProvider<ClassRoomBloc>(
            create: (context) => ClassRoomBloc(),
          ),
          BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(),
          ),
        ],
        child: MaterialApp(
          themeMode: ThemeMode.system,
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          initialRoute: routeRoot,
          navigatorKey: navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
