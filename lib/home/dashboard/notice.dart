import 'dart:io';

import 'package:attendance/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(notice());
}

class notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notice',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Portal'),
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
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => LeaveApplicationScreen()),
            //     );
            //   },
            //   child: Text('Leave Application'),
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 20),
            //     primary: Colors.orange,
            //     textStyle: TextStyle(fontSize: 18),
            //   ),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoticeScreen()),
                );
              },
              child: Text('Add Notice'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                primary: Colors.orange,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewNoticesScreen()),
                );
              },
              child: Text('Read Notices'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
      ),
    );
  }
}

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final TextEditingController _noticeTitleController = TextEditingController();
  final TextEditingController _noticeContentController =
      TextEditingController();

  final List<Map<String, String>> _notices = [];

  void _submitNotice() {
    final String title = _noticeTitleController.text;
    final String content = _noticeContentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      setState(() {
        _notices.add({
          'title': title,
          'content': content,
        });
        _noticeTitleController.clear();
        _noticeContentController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _noticeTitleController,
              decoration: InputDecoration(
                labelText: 'Notice Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _noticeContentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Notice Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.orange[50],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitNotice,
              child: Text('Submit Notice'),
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

class ViewNoticesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Notices'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<Map<String, String>>>(
          future: _fetchNotices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading notices'));
            } else {
              final notices = snapshot.data!;
              return ListView.builder(
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  final notice = notices[index];
                  return ListTile(
                    title: Text(notice['title']!),
                    subtitle: Text(notice['content']!),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, String>>> _fetchNotices() async {
    // In a real application, you would fetch the notices from a server or database.
    // For this example, we're just returning a static list of notices.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return [
      {'title': 'Notice 1', 'content': 'This is the first notice'},
      {'title': 'Notice 2', 'content': 'This is the second notice'},
    ];
  }
}
