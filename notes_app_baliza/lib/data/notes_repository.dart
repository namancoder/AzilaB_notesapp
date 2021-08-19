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
        .collection("notes");
    db.add(note.toMap());
  }

  Future<List<NotesModel>> getnotes() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

    var db = FirebaseFirestore.instance
        .collection("users")
        .doc("${prefs.get('key')}")
        .collection("notes");
    var data = await db.get();
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
