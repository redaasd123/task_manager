import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final DateTime? createAt;
  final String? title;
  final String? state;
  final String? desc;

  TaskModel({
    required this.id,
    required this.createAt,
    required this.title,
    required this.state,
    required this.desc,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json, String docId) {
    return TaskModel(
      id: docId,
      createAt: json['createAt'] != null
          ? (json['createAt'] is Timestamp
          ? (json['createAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['createAt'].toString()))
          : null,
      title: json['title'] as String?,
      state: json['state'] as String?,
      desc: json['desc'] as String?,
    );
  }
}
