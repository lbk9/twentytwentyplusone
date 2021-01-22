import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ttplusone/instructions.dart';
import 'package:ttplusone/memories.dart';

const String _memoryBox = 'memories';
const String _mantraBox = 'mantras';
const String _introBox = 'intro';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.openBox(_introBox);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TwentyTwenty+1',
      home: FutureBuilder(
          future: Hive.openBox(_memoryBox),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //seedData();

              if (Hive.box(_introBox).length == 1) {
                return Instructions();
              }
              return Memories();
            } else {
              return Scaffold();
            }
          }),
    );
  }

  seedData() async {
    var manBox = await Hive.openBox(_mantraBox);
    var memBox = await Hive.openBox(_memoryBox);

    memBox.add('Created this app in Flutter app in a morning.');
    memBox.add('Went a run for the first time since April, got the itch back.');
    memBox.add('Been to the gym 6 days in a row.');
    memBox.add('Set a new fastest lap on F1.');
    memBox.add('Finally finished painting the stairs.');
    memBox.add('Spent time with family when I could at Christmas.');

    manBox.add('Today will be better than yesterday');
    manBox.add('Failure to prepare is the best way to prepare for failure');
    manBox.add('Positivity wins. Always.');
  }

  @override
  void dispose() {
    Hive.box(_memoryBox).close();
    Hive.box(_mantraBox).close();
    super.dispose();
  }
}
