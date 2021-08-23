import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_baliza/add_notes.dart';
import 'package:notes_app_baliza/bloc/notes_bloc.dart';
import 'package:notes_app_baliza/data/notes_model.dart';
import 'package:notes_app_baliza/data/notes_repository.dart';
import 'package:notes_app_baliza/main.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.15,
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  _signOut();
                },
                child: Container(
                  width: 50.0,
                  margin: EdgeInsets.only(
                    top: 33.0,
                    bottom: 33.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)),
                  ),
                  child: Icon(Icons.search, color: Colors.purple[900]),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            leading: Container(
              height: 10.0,
              margin: EdgeInsets.only(
                top: 33.0,
                bottom: 33.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.purple[50],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
              ),
              //color: Colors.purple[50],
              child: Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.menu, color: Colors.purple[900])),
            ),
            centerTitle: true,
            title: Text(
              "MyNotes",
              style: TextStyle(
                  color: Colors.purple[900], fontWeight: FontWeight.bold),
            ),
          ),
          body: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetState) {
                return ListView.builder(
                    itemCount: state.userNotes!.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        key: Key(state.userNotes![i].title.toString()),
                        onDismissed: (direction) {
                          NotesRepository().deleteEmp(state.userNotes![i]);

                          setState(() {
                            state.userNotes!.removeAt(i);
                          });
                        },
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNote(
                                            isAdd: false,
                                            note: state.userNotes![i],
                                          ))),
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => SimpleDialog(
                              //     children: [
                              //       Text(("     ")),
                              //       Text(
                              //         ("   Title"),
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       Text(("     -" +
                              //           state.userNotes![i].title.toString())),
                              //       Text(
                              //         ("   Description"),
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       Text(("     -" +
                              //           state.userNotes![i].description
                              //               .toString())),
                              //     ],
                              //   ),
                              // ),
                              title: Text(state.userNotes![i].title.toString()),
                              subtitle: Text(
                                state.userNotes![i].description.toString(),
                                maxLines: 2,
                                style: TextStyle(fontSize: 12.0),
                              ),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.end,
                                direction: Axis.vertical,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[700],
                                      ),
                                      Icon(Icons.more_vert),
                                    ],
                                  ),
                                  Text(
                                    state.userNotes![i].datetime.toString(),
                                    style: TextStyle(fontSize: 10.0),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    });
              } else {
                return Center();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNote(
                          isAdd: true,
                          note: NotesModel(),
                        ))),
            child: Icon(
              Icons.add,
              size: 40.0,
            ),
          )
          // Center(
          //   child: Stack(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Align(
          //           child: FloatingActionButton(
          //               heroTag: "signout",
          //               child: Icon(Icons.exit_to_app_sharp),
          //               backgroundColor: Colors.red,
          //               onPressed: () => _signOut()),
          //           alignment: Alignment.bottomLeft,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Align(
          //           child: FloatingActionButton(
          //               heroTag: "AddNote",
          //               child: Icon(Icons.add, size: 40),
          //               backgroundColor: Colors.purple,
          //               onPressed: () => Navigator.push(context,
          //                   MaterialPageRoute(builder: (ctx) => AddNote()))),
          //           alignment: Alignment.bottomRight,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }

  _signOut() async {
    await NotesRepository().getCurrentUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext ctx) => MyApp()));
  }
}
