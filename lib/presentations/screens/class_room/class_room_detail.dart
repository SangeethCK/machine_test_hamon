import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/presentations/screens/subject/subject_screen.dart';

class ClassRoomDetailScreen extends StatelessWidget {
  const ClassRoomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Oldlace',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              20.verticalSpace,
              const SubjectCard(),
              20.verticalSpace,
              const ClassroomLayout(),
              20.verticalSpace,
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.teal[100],
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Subject Updated'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassRoomBloc, ClassRoomState>(
      builder: (context, state) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: ListTile(
            title: const Text('Add Subject'),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SubjectScreen(
                    isValue: true,
                  );
                }));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.teal[100],
              ),
              child: const Text('Change'),
            ),
          ),
        );
      },
    );
  }
}

class ClassroomLayout extends StatelessWidget {
  const ClassroomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassRoomBloc, ClassRoomState>(
      builder: (context, state) {
        int value = (state.classDetail?.size ?? 0) ~/ 2;

        List<Widget> leftChairs = List.generate(
          value,
          (index) => Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              'assets/images/sitting-on-a-chair 1.png',
              height: 40,
            ),
          ),
        );

        List<Widget> rightChairs = List.generate(
          value,
          (index) => Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              'assets/images/sitting-on-a-chair 9.png',
              height: 40,
            ),
          ),
        );

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: leftChairs,
              ),
              Container(
                width: 90,
                height: 550.sp,
                color: Colors.grey.shade200,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: rightChairs,
              ),
            ],
          ),
        );
      },
    );
  }
}
