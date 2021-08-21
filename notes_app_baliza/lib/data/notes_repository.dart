import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_baliza/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'notes_model.dart';

class NotesRepository {
  //FirebaseFirestore.instance

  // var db = FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("${uidUser}")
  //     .collection("notes");
  //var settings = new FirebaseFirestoreSettings.;

  addEmp(NotesModel note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var db = FirebaseFirestore.instance
        .collection("users")
        .doc("${prefs.get('key')}")
        .collection("notes")
        .doc();
    db.set(note.toMap()).then((value) {
      print("Success");
      Map<String, dynamic> data = <String, dynamic>{
        "title": note.title,
        "description": note.description,
        "datetime": note.datetime,
        "id": db.id,
      };
      db.set(data).then((value) {
        print("Completely Succesfully");
        print(db.id);
      });

      // print(value.id);
    }).catchError((error) {
      print("Errror");
      print(error);
    });
  }

  deleteEmp(NotesModel note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var db = FirebaseFirestore.instance
        .collection("users")
        .doc("${prefs.get('key')}")
        .collection("notes")
        .doc(note.id);
    print("NOTE ID DELETED" + note.id.toString());

    db
        .delete() // <-- Delete
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    // await db
    //     .delete()
    //     .whenComplete(() => print('Note item deleted from the database'))
    //     .catchError((e) => print(e));
  }

  updateEmp(NotesModel note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var db = FirebaseFirestore.instance
        .collection("users")
        .doc("${prefs.get('key')}")
        .collection("notes")
        .doc();

    db.set(note.toMap()).then((value) {
      print("Success");
    }).catchError((error) {
      print("Errror");
      print(error);
    });
  }

  Future<List<NotesModel>> getnotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var db = FirebaseFirestore.instance
        .collection("users")
        .doc("${prefs.get('key')}")
        .collection("notes");
    var data = await db.get();

    print(data.toString());
    var notes = data.docs.map((e) => NotesModel.fromMap(e.data())).toList();

    return notes;
  }

  Future getCurrentUser() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('key');
    // Navigator.push(
    //     MaterialPageRoute(builder: (context) => MyHomePage(title: "Notes App Baliza")));
  }
}
