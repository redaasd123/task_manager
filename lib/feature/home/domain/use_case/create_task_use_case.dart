import 'package:dartz/dartz.dart';
import 'package:task_manager/core/use_case/use_case.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';
import '../../../../core/error/fire_base_failure.dart';
import 'package:task_manager/feature/home/domain/param.dart';

import '../entity/task_entity.dart';

class CreateTaskUseCase extends UseCase<TaskEntity,CreateTaskParam>{
  final HomeRepo homeRepo;

  CreateTaskUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, TaskEntity>> call(param)async {
    return await homeRepo.createTask(param);
  }


}