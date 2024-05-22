import 'package:flutter/material.dart';

class ClassRoomDetailScreen extends StatelessWidget {
  const ClassRoomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Oldlace',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const SubjectCard(),
            const SizedBox(height: 20),
            const ClassroomLayout(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
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
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        title: const Text('Biology'),
        subtitle: const Text('Erin Walsh'),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle change subject button press
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.teal[100],
          ),
          child: const Text('Change'),
        ),
      ),
    );
  }
}

class ClassroomLayout extends StatelessWidget {
  const ClassroomLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: List.generate(
                8,
                (index) => Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child:
                        Image.asset('assets/images/sitting-on-a-chair 1.png'))),
          ),
          Container(
            width: 100,
            height: 400,
            color: Colors.grey.shade200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                8,
                (index) => Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child:
                        Image.asset('assets/images/sitting-on-a-chair 9.png'))),
          ),
        ],
      ),
    );
  }
}
