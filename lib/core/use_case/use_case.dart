import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/fire_base_failure.dart';

abstract class UseCase<type, param> {
  Future<Either<Failure, type>> call(param param);
}

class NoParam {}
