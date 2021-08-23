import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icon.dart';
import 'package:notes_app_baliza/bloc/notes_bloc.dart';
import 'package:notes_app_baliza/data/notes_model.dart';
import 'package:notes_app_baliza/notes_list.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class AddNote extends StatefulWidget {
  final bool isAdd;
  final NotesModel note;

  AddNote({
    required this.isAdd,
    required this.note,
  });

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var title = TextEditingController();

  var description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isAdd) {
      title.text = widget.note.title.toString();
      description.text = widget.note.description.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("NOTE ID");
    print(widget.note.id);
    return Scaffold(
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(LineIcons.pen),
            Icon(
              Icons.star,
              color: Colors.yellow[700],
            ),
            Icon(LineIcons.share),
            Icon(Icons.more_vert),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.fromLTRB(0, 35, 20, 35),
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
            child: Icon(Icons.arrow_back_ios, color: Colors.purple[900]),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        backgroundColor: Colors.white,
      ),
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is AddState || state is UpdateState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NotesList()));
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: title,
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.purple[900],
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusColor: Colors.purple[900],
                      fillColor: Colors.purple[900],
                      hintText: "Title",
                      hintStyle: TextStyle(
                          fontSize: 25.0,
                          color: Colors.purple[900],
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    maxLines: 25,
                    minLines: 12,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusColor: Colors.purple[900],
                      fillColor: Colors.purple[900],
                      hintText: widget.isAdd ? "Description" : null,
                      hintStyle: TextStyle(
                          fontSize: 25.0,
                          color: Colors.purple[900],
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Row(children: [
                    Text(
                      DateFormat("MMMM d, y, hh:mm")
                          .format(DateTime.now())
                          .toString(),
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300),
                    ),
                  ]),
                ),
                Container(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple)),
                  onPressed: () {
                    if (widget.isAdd)
                      BlocProvider.of<NotesBloc>(context).add(AddEvent(
                          title: title.text, description: description.text));
                    else if (!widget.isAdd)
                      BlocProvider.of<NotesBloc>(context).add(UpdateEvent(
                          title: title.text,
                          description: description.text,
                          id: widget.note.id));
                  },
                  child: Text(widget.isAdd == true ? "Add" : "Update"),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
