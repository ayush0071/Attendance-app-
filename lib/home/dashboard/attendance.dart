import 'package:flutter/material.dart';

void main() {
  runApp(AttendanceScreen());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final Map<String, String> _attendance = {};

  void _markAttendance() {
    final String name = _nameController.text;
    final String status = _statusController.text;

    if (name.isNotEmpty && status.isNotEmpty) {
      setState(() {
        _attendance[name] = status;
        _nameController.clear();
        _statusController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both name and status')),
      );
    }
  }

  void _viewAttendance() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Attendance'),
          content: _attendance.isNotEmpty
              ? SingleChildScrollView(
                  child: ListBody(
                    children: _attendance.entries
                        .map((entry) => Text('${entry.key}: ${entry.value}'))
                        .toList(),
                  ),
                )
              : Text('No attendance records available.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _markAttendance,
              child: Text('Mark Attendance'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                primary: Colors.orange,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _viewAttendance,
              child: Text('View Attendance'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                primary: Colors.orange,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
