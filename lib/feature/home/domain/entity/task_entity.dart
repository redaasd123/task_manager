import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable{
  final String id;
  final DateTime createAt;
  final String title;
  final String state;
  final String desc;
  final bool isSynced;

  TaskEntity({
    required this.isSynced,
    required this.id,
    required this.createAt,
    required this.title,
    required this.state,
    required this.desc,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,createAt,title,state,desc,isSynced];
}
