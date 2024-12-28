
import 'package:katsimon_oleh_kiuki_21_9/models/student.dart';
import 'package:katsimon_oleh_kiuki_21_9/widgets/new_student.dart';
import 'package:katsimon_oleh_kiuki_21_9/widgets/students.dart';
import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {

  Color _getBackgroundColor(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Colors.blue.shade300;
      case Gender.female:
        return Colors.pink.shade300;
    }
  }

  void _showAddStudentModal() async {
    final newStudent = await showModalBottomSheet<Student>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NewStudent();
      },
    );

    if (newStudent != null) {
      setState(() {
        students.add(newStudent);
      });
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return _buildStudentCard(student, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentModal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStudentCard(Student student, int index) {
    return InkWell(
      onTap: () async {
      final updatedStudent = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewStudent(
            studentToEdit: student,
          ),
        ),
      );

      if (updatedStudent != null) {
        setState(() {
          students[index] = updatedStudent;
        });
      }
    },
      child: Dismissible(
        key: Key(student.firstName + student.lastName),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          final removedStudent = students[index];
          setState(() {
            students.removeAt(index);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${student.firstName} ${student.lastName} removed'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
              setState(() {
                students.insert(index, removedStudent);
              });
            },
          ),
            ),
          );
        },
        background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          elevation: 4,
          color: _getBackgroundColor(student.gender),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              '${student.firstName} ${student.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(departmentIcons[student.department], size: 20),
                const SizedBox(width: 8),
                Text(
                  '${student.grade}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}