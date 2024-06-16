import 'package:attendance/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(LeaveApplication());
}

class LeaveApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leave Application',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LeaveApplicationScreen(),
    );
  }
}

class LeaveApplicationScreen extends StatefulWidget {
  @override
  _LeaveApplicationScreenState createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  final Map<String, Map<String, String>> _leaveApplications = {};

  void _submitLeaveApplication() {
    final String employeeId = _employeeIdController.text;
    final String name = _nameController.text;
    final String leaveType = _leaveTypeController.text;
    final String startDate = _startDateController.text;
    final String endDate = _endDateController.text;
    final String reason = _reasonController.text;

    if (employeeId.isNotEmpty &&
        name.isNotEmpty &&
        leaveType.isNotEmpty &&
        startDate.isNotEmpty &&
        endDate.isNotEmpty &&
        reason.isNotEmpty) {
      setState(() {
        _leaveApplications[employeeId] = {
          'name': name,
          'leaveType': leaveType,
          'startDate': startDate,
          'endDate': endDate,
          'reason': reason,
        };
        _employeeIdController.clear();
        _nameController.clear();
        _leaveTypeController.clear();
        _startDateController.clear();
        _endDateController.clear();
        _reasonController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Application'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _employeeIdController,
              decoration: InputDecoration(
                labelText: 'Employee ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
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
              controller: _leaveTypeController,
              decoration: InputDecoration(
                labelText: 'Leave Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _startDateController,
              readOnly: true,
              onTap: () => _selectDate(_startDateController),
              decoration: InputDecoration(
                labelText: 'Start Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _endDateController,
              readOnly: true,
              onTap: () => _selectDate(_endDateController),
              decoration: InputDecoration(
                labelText: 'End Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                labelText: 'Reason for Leave',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitLeaveApplication,
              child: Text('Submit Leave Application'),
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
