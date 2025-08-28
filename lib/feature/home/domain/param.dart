import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTaskParam {
  final String title;
  final String state;
  final String desc;

  CreateTaskParam({
    required this.title,
    required this.state,
    required this.desc,
  });

  Map<String, dynamic> toJson() {
    return {
      "desc": desc,
      "state": state,
      "title": title,
      "createAt": FieldValue.serverTimestamp(),
    };
  }
}

class DeleteTaskParam {
  final String id;

  DeleteTaskParam({required this.id});

  Map<String, dynamic> toJson() {
    return {"id": id};
  }
}

class EditTaskParam {
  final String id;
  final String title;
  final String state;
  final String desc;

  EditTaskParam({
    required this.id,
    required this.title,
    required this.state,
    required this.desc,
  });

  Map<String, dynamic> toJson() {
    return {
      "desc": desc,
      "state": state,
      "title": title,
      "createAt": FieldValue.serverTimestamp(),
    };
  }
}
