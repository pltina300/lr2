import 'package:katsimon_oleh_kiuki_21_9/models/student.dart';
import 'package:katsimon_oleh_kiuki_21_9/widgets/student_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     Student student = Student(
      firstName: "John",
      lastName: "Doe",
      department: Department.it,
      grade: 5,
      gender: Gender.male,
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: StudentsScreen(),
        ),
      ),
    );
  }
}
