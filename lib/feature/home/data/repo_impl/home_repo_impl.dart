import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager/core/utils/message.dart';
import 'package:task_manager/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';

import '../../../../core/connectivity/check_internet_cubit.dart';
import '../../../../core/error/fire_base_failure.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final CheckInternetCubit internetCubit;

  HomeRepoImpl(this.internetCubit, {required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    try {
      var result = await homeRemoteDataSource.fetchTasks();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? "Firebase error occurred"));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTask(CreateTaskParam param) async {
    try {
      if (internetCubit.state is ConnectivityDisconnected) {
        return Left(NetworkFailure(noInternetMessage));
      }
      var result = await homeRemoteDataSource.createTask(param);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? "Firebase error occurred"));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(DeleteTaskParam param) async {
    try {
      if (internetCubit.state is ConnectivityDisconnected) {
        return Left(NetworkFailure(noInternetMessage));
      }
      var result = await homeRemoteDataSource.deleteTask(param);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? "Firebase error occurred"));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> editTask(EditTaskParam param) async {
    try {
      if (internetCubit.state is ConnectivityDisconnected) {
        return Left(NetworkFailure(noInternetMessage));
      }
      var result = await homeRemoteDataSource.editTask(param);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? "Firebase error occurred"));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
