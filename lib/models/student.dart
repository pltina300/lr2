import 'package:flutter/material.dart';

enum Department {
  finance,
  law,
  it,
  medical
}

final Map<Department, IconData> departmentIcons = {
  Department.finance: Icons.attach_money,
  Department.law: Icons.gavel,
  Department.it: Icons.computer,
  Department.medical: Icons.local_hospital,
};

enum Gender {
  male,
  female
}

class Student {
  String firstName;
  String lastName;
  Department department;
  int grade;
  Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}