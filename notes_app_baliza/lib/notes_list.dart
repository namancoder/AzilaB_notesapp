import 'package:flutter/material.dart';
import 'package:notes_app_baliza/data/notes_repository.dart';
import 'package:notes_app_baliza/main.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                child: FloatingActionButton(
                    child: Icon(Icons.exit_to_app_sharp),
                    backgroundColor: Colors.red,
                    onPressed:()=> _signOut()),
                alignment: Alignment.bottomLeft,
              ),
            ),
          ],
        )),
      ),
    );
  }

  _signOut() async {
    await NotesRepository().getCurrentUser();
     Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => MyApp()));
  }
}
