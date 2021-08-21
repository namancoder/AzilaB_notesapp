class NotesModel {
  String? title;
  String? description;
  String? datetime;
  String? id;
  NotesModel({this.title, this.description, this.datetime, this.id});

  toMap() => {
        'title': title,
        'description': description,
        'datetime': datetime,
        'id':id,
      };

  NotesModel.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        description = map['description'],
        datetime = map['datetime'],
        id = map['id'];
}
