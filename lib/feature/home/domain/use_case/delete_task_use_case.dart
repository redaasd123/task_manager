import 'package:dartz/dartz.dart';
import 'package:task_manager/core/use_case/use_case.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';

import '../../../../core/error/fire_base_failure.dart';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/use_case/use_case.dart';
import 'package:task_manager/feature/home/domain/param.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';

import '../../../../core/error/fire_base_failure.dart';

class DeleteTaskUseCase extends UseCase<Unit,DeleteTaskParam>{
  final HomeRepo homeRepo;

  DeleteTaskUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, Unit>> call(param)async {
    return await homeRepo.deleteTask(param);
  }


}