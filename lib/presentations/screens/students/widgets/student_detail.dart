import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/applications/students/students_bloc.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Detail'),
        centerTitle: true,
      ),
      body: MainPadding(
        child: BlocProvider(
          create: (context) => StudentsBloc()..add(LoadStudentDetailsEvent(id)),
          child: BlocConsumer<StudentsBloc, StudentsState>(
            listener: (context, state) {
              if (state.getStatus == ApiFetchStatus.failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Failed to load student details')),
                );
              }
            },
            builder: (context, state) {
              if (state.getStatus == ApiFetchStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.getStatus == ApiFetchStatus.success) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Image.asset('assets/images/Ellipse 1.png'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        state.studentDetail?.name ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Age : ${state.studentDetail?.age.toString() ?? ''}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.studentDetail?.email ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.getStatus == ApiFetchStatus.failed) {
                return const Center(
                    child: Text('Failed to load student details'));
              }
              return const Center(child: Text('Unknown State'));
            },
          ),
        ),
      ),
    );
  }
}
