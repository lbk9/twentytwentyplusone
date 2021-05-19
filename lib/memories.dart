import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math';

import 'package:ttplusone/newmemory.dart';
import 'package:ttplusone/services/mantraservice.dart';

const String memoryBox = 'memories';

class Memories extends StatefulWidget {
  @override
  _MemoriesState createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  @override
  Widget build(BuildContext context) {
    MantraService mantraService = MantraService();

    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'TwentyTwenty+1',
              style: GoogleFonts.raleway(),
            )),
        backgroundColor: Colors.deepPurple[700],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                elevation: 10,
                color: Colors.purple[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Mantra of the Day',
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 28),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(mantraService.getMantra(),
                          style: GoogleFonts.raleway(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Highlights',
                  style: GoogleFonts.raleway(
                      fontSize: 28, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.5,
                child: buildList()),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewMemory()));
        },
        backgroundColor: Colors.purple[200],
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildList() {
    var _memBox = Hive.box(memoryBox).listenable();
    return ValueListenableBuilder(
        valueListenable: _memBox,
        builder: (context, box, widget) {
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    background: stackBehindDismiss(),
                    key: UniqueKey(),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.1))),
                      child: ListTile(
                        title: Text(Hive.box(memoryBox).getAt(index)),
                      ),
                    ),
                    onDismissed: (direction) {
                      Hive.box(memoryBox).deleteAt(index);
                    });
              });
        });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text('Removing memory from my mind...',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 14)),
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
