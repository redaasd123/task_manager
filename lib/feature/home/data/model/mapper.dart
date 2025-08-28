import 'package:task_manager/feature/home/data/model/task_model.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';

extension GetTaskMapper on TaskModel {
  TaskEntity toEntity() {
    return TaskEntity(
      isSynced: true,
      id:id,
      createAt: createAt ?? DateTime.now(),
      title: title??'',
      state: state??'',
      desc: desc??'',
    );
  }
}
