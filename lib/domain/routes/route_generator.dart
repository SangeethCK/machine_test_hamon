import 'package:flutter/material.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/presentations/screens/class_room/class_room_detail.dart';
import 'package:machine_test/presentations/screens/home/home_screen.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    switch (routeSettings.name) {
      case routeRoot:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case student:
        return MaterialPageRoute(builder: (_) => const StudentScreen());
      case classRoomDetail:
        return MaterialPageRoute(builder: (_) => const ClassRoomDetailScreen());

      // case routeHome:
      //   if (args is Map) {
      //     return MaterialPageRoute(
      //         builder: (_) =>
      //             HomeScreen(redirectionUrl: args['redirectionUrl']));
      //   }
      //   return _errorRoute(argsError: true);

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute({String? error, bool argsError = false}) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            error ?? '${argsError ? 'Arguments' : 'Navigation'} Error',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
