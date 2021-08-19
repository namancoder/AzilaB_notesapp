import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app_baliza/bloc/notes_bloc.dart';
import 'package:notes_app_baliza/data/notes_repository.dart';
import 'package:notes_app_baliza/notes_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var UserUID = prefs.get('key');

  runApp(UserUID == null
      ? MyApp()
      : BlocProvider<NotesBloc>(
          create: (context) => NotesBloc(NotesRepository()),
          child: NotesList(),
        ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Notes App Baliza'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign In"),
              GestureDetector(
                child: Icon(Icons.person),
                onTap: () {
                  signup(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// function to implement the google signin

// creating firebase instance

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signup(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Getting users credential
    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;
    print(user.toString());

    if (result != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('key', '${auth.currentUser!.uid}');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => NotesList()));
    } // if result not null we simply call the MaterialpageRoute,
    // for go to the HomePage screen
  }
}
