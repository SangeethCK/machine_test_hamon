import 'package:flutter/material.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(title: 'Hello Good',),
      body: Column(
        children: [],
      ),
    );
  }
}
