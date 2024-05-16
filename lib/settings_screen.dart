import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

List<String> settings = ["firstMove"];
class Setting {
  String name;
  String value;

  Setting(this.name, this.value);
}
var behaviorSubject = BehaviorSubject<Setting>();

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _firstMoveOption = 'Player always First';
  final List<String> _firstMoveOptions = [
    'Player always First',
    'Computer always First',
    'Random',
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstMoveOption = prefs.getString('firstMoveOption') ?? _firstMoveOptions[0];
    });
  }

  void _saveFirstMoveOption(String selectedOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstMoveOption', selectedOption);
    behaviorSubject.add(Setting("FirstMoveOption", selectedOption));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select who goes first:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            DropdownButton<String>(
              value: _firstMoveOption,
              onChanged: (String? newValue) {
                setState(() {
                  _firstMoveOption = newValue ?? '';
                  _saveFirstMoveOption(newValue ?? '');
                });
              },
              items: _firstMoveOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
