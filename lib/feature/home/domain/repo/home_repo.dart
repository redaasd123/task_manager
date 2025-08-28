import 'package:dartz/dartz.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';

import '../../../../core/error/fire_base_failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, TaskEntity>> createTask(CreateTaskParam param);

  Future<Either<Failure, TaskEntity>> editTask(EditTaskParam param);

  Future<Either<Failure, Unit>> deleteTask(DeleteTaskParam param);
}
