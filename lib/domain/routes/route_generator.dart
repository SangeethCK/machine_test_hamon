import 'package:flutter/material.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/presentations/screens/class_room/class_room.dart';
import 'package:machine_test/presentations/screens/home/home_screen.dart';
import 'package:machine_test/presentations/screens/registration/registration_screen.dart';
import 'package:machine_test/presentations/screens/registration/new_register_screen.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/screens/students/widgets/student_detail.dart';
import 'package:machine_test/presentations/screens/subject/subject_screen.dart';
import 'package:machine_test/presentations/screens/subject/widgets/subject_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    switch (routeSettings.name) {
      case routeRoot:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case student:
        return MaterialPageRoute(builder: (_) => const StudentScreen());
      case subjects:
        return MaterialPageRoute(builder: (_) => const SubjectScreen());
      case classRoom:
        return MaterialPageRoute(builder: (_) => const ClassRoomScreen());
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case newRegister:
        return MaterialPageRoute(builder: (_) => const NewRegisterScreen());
      case subjectDetail:
        return MaterialPageRoute(builder: (_) => const SubjectDetailsScreen());
      // case classRoomDetail:
      //   return MaterialPageRoute(builder: (_) => const ClassRoomDetailScreen());

      case studentDetail:
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => StudentDetailScreen(
                    id: args['id'],
                  ));
        } else {
          return _errorRoute(argsError: true);
        }

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
