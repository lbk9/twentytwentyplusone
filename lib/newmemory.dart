import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:ttplusone/memories.dart';

class NewMemory extends StatefulWidget {
  @override
  _NewMemoryState createState() => _NewMemoryState();
}

class _NewMemoryState extends State<NewMemory> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New Memory',
                style: GoogleFonts.raleway(),
              )),
          backgroundColor: Colors.deepPurple[700],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Image.asset('assets/think.png'),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: myController,
                          decoration: new InputDecoration(
                            hintText: "What's on your mind...",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Looks like you never added a memory..';
                            }
                            return null;
                          },
                        ),
                        submitButtonWithSnackbar(),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  Widget submitButtonWithSnackbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Builder(
        builder: (context) => ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.purple[200], onPrimary: Colors.white),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Hive.box(memoryBox).add(myController.text);
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Adding memory...')));
              Navigator.of(context).pop();
            }
          },
          child: Text('Submit'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
