import 'package:dartz/dartz.dart';
import 'package:task_manager/core/use_case/use_case.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';

import '../../../../core/error/fire_base_failure.dart';

class FetchTaskUseCase extends UseCase<List<TaskEntity>,NoParam>{
  final HomeRepo homeRepo;

  FetchTaskUseCase({required this.homeRepo});
  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParam param)async {
return await homeRepo.fetchTasks();
  }
}