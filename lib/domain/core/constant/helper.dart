import 'package:machine_test/domain/core/constant/images.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';

class Demo {
  String name;
  String icon;
  Demo({
    required this.name,
    required this.icon,
  });
}

List<Demo> homeList = [
  Demo(name: StringConstant.students, icon: Assets.studentIcon),
  Demo(name: StringConstant.subjects, icon: Assets.subjectIcon),
  Demo(name: StringConstant.classRoom, icon: Assets.classRoomIcon),
  Demo(name: StringConstant.registration, icon: Assets.registrationIcon)
];
