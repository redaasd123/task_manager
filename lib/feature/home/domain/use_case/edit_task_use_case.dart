import 'package:dartz/dartz.dart';
import 'package:task_manager/core/use_case/use_case.dart';
import 'package:task_manager/feature/home/domain/param.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';

import '../../../../core/error/fire_base_failure.dart';
import '../entity/task_entity.dart';

class EditTaskUseCase extends UseCase<TaskEntity,EditTaskParam>{
  final HomeRepo homeRepo;

  EditTaskUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, TaskEntity>> call(param)async {
return await homeRepo.editTask(param);
  }


}