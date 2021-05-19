import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ttplusone/instructions.dart';
import 'package:ttplusone/memories.dart';

const String _memoryBox = 'memories';
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

              if (Hive.box(_introBox).length == 0) {
                return Instructions();
              }
              return Memories();
            } else {
              return Scaffold();
            }
          }),
    );
  }

  @override
  void dispose() {
    Hive.box(_memoryBox).close();
    super.dispose();
  }
}
