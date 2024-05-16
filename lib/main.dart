import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoesettings/settings_screen.dart';
// make sure to flutter pub add shared_preferences
void main() {
  runApp(MaterialApp(home: GameScreen()));
}


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GameScreenState();

}
class _GameScreenState extends State<GameScreen> {
  String _firstMoveOption = "";
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstMoveOption = prefs.getString('firstMoveOption') ?? "Options Not read";
      print("FMO: $_firstMoveOption");
    });
    behaviorSubject.stream.listen((settingsData) {
      print("update2:" + settingsData.value);
      setState(() {
        _firstMoveOption = settingsData.value;
        print("state is updated:" + _firstMoveOption);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text('Tic Tac Toe Board Goes Here!'),
          ),
          Center(
            child: Text('"$_firstMoveOption"'),
          ),
        ],
      ),
    );
  }
}

