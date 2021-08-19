class NotesModel {
  String? title;
  String? description;
  String? datetime;
  NotesModel({this.title, this.description, this.datetime});

  toMap() => {
        'title': title,
        'description': description,
        'datetime': datetime,
      };

  NotesModel.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        description = map['desciption'],
        datetime = map['datetime'];
}
