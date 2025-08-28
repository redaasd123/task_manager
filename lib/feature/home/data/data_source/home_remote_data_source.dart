import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager/core/utils/constance.dart';
import 'package:task_manager/feature/home/data/model/mapper.dart';
import 'package:task_manager/feature/home/data/model/task_model.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';

abstract class HomeRemoteDataSource {
  Future<List<TaskEntity>> fetchTasks();

  Future<TaskEntity> createTask(CreateTaskParam param);

  Future<Unit> deleteTask(DeleteTaskParam param);

  Future<TaskEntity> editTask(EditTaskParam param);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<List<TaskEntity>> fetchTasks() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(kTaskCollection)
        .orderBy('createAt', descending: true)
        .get();

    List<TaskEntity> allTasks = snapshot.docs
        .map(
          (doc) => TaskModel.fromJson(
        doc.data() as Map<String, dynamic>,
        doc.id,
      ).toEntity(),
    )
        .toList();
    print(
      "📦 Raw Firestore data: ${snapshot.docs.map((e) => e.data()).toList()}",
    );
    return allTasks;
  }

  @override
  Future<TaskEntity> createTask(CreateTaskParam param) async {
    final docRef = await FirebaseFirestore.instance
        .collection(kTaskCollection)
        .add(param.toJson());
    final snap = await docRef.get();
    return TaskModel.fromJson(
      snap.data() as Map<String, dynamic>,
      snap.id,
    ).toEntity();
  }

  @override
  Future<TaskEntity> editTask(EditTaskParam param) async {
    final docRef = FirebaseFirestore.instance
        .collection(kTaskCollection)
        .doc(param.id);

    await docRef.update(param.toJson());

    final updatedDoc = await docRef.get();

    return TaskModel.fromJson(updatedDoc.data()!, updatedDoc.id).toEntity();
  }

  @override
  Future<Unit> deleteTask(DeleteTaskParam param) async {
    await FirebaseFirestore.instance
        .collection(kTaskCollection)
        .doc(param.id)
        .delete();
    return unit;
  }
}
