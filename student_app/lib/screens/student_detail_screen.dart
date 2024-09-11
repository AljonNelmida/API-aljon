import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';


class StudentDetailScreen extends StatefulWidget {
  final Student student;
  StudentDetailScreen({required this.student});

  @override
  _StudentDetailScreenState createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  String course = 'First Year';
  bool enrolled = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.student.firstName);
    lastNameController = TextEditingController(text: widget.student.lastName);
    course = widget.student.course;
    enrolled = widget.student.enrolled;
  }

  void _updateStudent() {
    if (_formKey.currentState!.validate()) {
      final updatedStudent = Student(
        id: widget.student.id,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        course: course,
        year: widget.student.year,
        enrolled: enrolled,
      );
      ApiService().updateStudent(widget.student.id, updatedStudent).then((_) {
        Navigator.pop(context);
      });
    }
  }

  void _deleteStudent() {
    ApiService().deleteStudent(widget.student.id).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteStudent,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
                value: course,
                onChanged: (String? newValue) {
                  setState(() {
                    course = newValue!;
                  });
                },
                items: <String>[
                  'First Year',
                  'Second Year',
                  'Third Year',
                  'Fourth Year',
                  'Fifth Year'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SwitchListTile(
                title: Text('Enrolled'),
                value: enrolled,
                onChanged: (bool value) {
                  setState(() {
                    enrolled = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _updateStudent,
                child: Text('Update Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
