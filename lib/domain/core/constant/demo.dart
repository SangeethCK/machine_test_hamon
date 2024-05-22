class Demo {
  String name;
  String icon;
  Demo({
    required this.name,
    required this.icon,
  });
}

List<Demo> homeList = [
  Demo(name: 'Students', icon: 'assets/images/icons8_student.svg'),
  Demo(name: 'Subjects', icon: 'assets/images/akar-icons_book.svg'),
  Demo(
      name: 'Class Rooms',
      icon: 'assets/images/fluent_conference-room-24-regular.svg'),
  Demo(name: 'Registration', icon: 'assets/images/Group.svg')
];
