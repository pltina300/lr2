import 'package:katsimon_oleh_kiuki_21_9/models/student.dart';
import 'package:flutter/material.dart';

class NewStudent extends StatefulWidget {
  final Student? studentToEdit;

  const NewStudent({Key? key, this.studentToEdit}) : super(key: key);

  @override
    _StudentFormScreenState createState() => _StudentFormScreenState();
}

class StudentFormScreen extends StatefulWidget {
  final Student? editableStudent;

  const StudentFormScreen({Key? key, this.editableStudent}) : super(key: key);

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _gradeCtrl;

  Department _departmentChoice = Department.it;
  Gender _genderChoice = Gender.male;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController(
      text: widget.editableStudent?.firstName ?? '',
    );
    _lastNameCtrl = TextEditingController(
      text: widget.editableStudent?.lastName ?? '',
    );
    _gradeCtrl = TextEditingController(
      text: widget.editableStudent?.grade.toString() ?? '',
    );
    _departmentChoice = widget.editableStudent?.department ?? Department.it;
    _genderChoice = widget.editableStudent?.gender ?? Gender.male;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _gradeCtrl.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newStudent = Student(
        firstName: _firstNameCtrl.text,
        lastName: _lastNameCtrl.text,
        department: _departmentChoice,
        grade: int.tryParse(_gradeCtrl.text) ?? 0,
        gender: _genderChoice,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.editableStudent == null
              ? 'New student added successfully!'
              : 'Student updated successfully!'),
        ),
      );

      Navigator.pop(context, newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editableStudent == null ? 'Add Student' : 'Edit Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField(
                controller: _firstNameCtrl,
                label: 'First Name',
                validator: (value) =>
                    value == null || value.isEmpty ? 'First Name is required' : null,
              ),
              _buildInputField(
                controller: _lastNameCtrl,
                label: 'Last Name',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Last Name is required' : null,
              ),
              _buildInputField(
                controller: _gradeCtrl,
                label: 'Grade',
                inputType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Grade is required' : null,
              ),
              _buildDropdown<Gender>(
                value: _genderChoice,
                items: Gender.values,
                label: 'Gender',
                onChanged: (value) {
                  setState(() {
                    _genderChoice = value!;
                  });
                },
              ),
              _buildDropdown<Department>(
                value: _departmentChoice,
                items: Department.values,
                label: 'Department',
                onChanged: (value) {
                  setState(() {
                    _departmentChoice = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.editableStudent == null ? 'Add Student' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required String label,
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item.toString().split('.').last)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
