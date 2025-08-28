import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/core/use_case/use_case.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';
import 'package:task_manager/feature/home/domain/use_case/create_task_use_case.dart';
import 'package:task_manager/feature/home/domain/use_case/delete_task_use_case.dart';
import 'package:task_manager/feature/home/domain/use_case/edit_task_use_case.dart';
import 'package:task_manager/feature/home/domain/use_case/fetch_task_use_case.dart';

import '../../../../core/error/fire_base_failure.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.fetchTaskUseCase,
    this.createTaskUseCase,
    this.editTaskUseCase,
    this.deleteTaskUseCase,
  ) : super(FetchTaskInitialState());
  final FetchTaskUseCase fetchTaskUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final EditTaskUseCase editTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  List<TaskEntity> allTask = [];
  String selectState = 'All';
  bool isFirstFetch = true;
  bool isSynced = true;

  Future<void> fetchTask() async {
    emit(FetchTaskLoadingState());
    var result = await fetchTaskUseCase.call(NoParam());
    result.fold(
      (failure) {
        emit(FetchTaskFailureState(errMessage: failure.message));
      },
      (task) {
        allTask = task;
        emit(FetchTaskSuccessState(List.from(task)));
        isFirstFetch = false;
      },
    );
  }

  Future<void> createTask(CreateTaskParam param) async {
    emit(CreateTaskLoadingState());
    var result = await createTaskUseCase.call(param);
    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          emit(CreateTaskFailureState(errMessage: failure.message));
        } else {
          emit(CreateTaskFailureState(errMessage: failure.message));
        }
      },
      (task) {
        allTask.insert(0, task);
        emit(CreateTaskSuccessState());
        emit(FetchTaskSuccessState(List.from(allTask)));
      },
    );
  }

  Future<void> editTask(EditTaskParam param) async {
    emit(EditTaskLoadingState());
    var result = await editTaskUseCase.call(param);
    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          emit(EditTaskFailureState(errMessage: failure.message));
        } else {
          emit(EditTaskFailureState(errMessage: failure.message));
        }
      },
      (task) {
        allTask = allTask.map((t) => t.id == task.id ? task : t).toList();
        emit(EditTaskSuccessState());
        emit(FetchTaskSuccessState(List.from(allTask)));
      },
    );
  }

  Future<void> deleteTask(DeleteTaskParam param) async {
    emit(DeleteTaskLoadingState());
    var result = await deleteTaskUseCase.call(param);
    result.fold(
      (failure) {
        if(failure is NetworkFailure){
          emit(DeleteTaskFailureState(errMessage: failure.message));
        }else{
          emit(DeleteTaskFailureState(errMessage: failure.message));
        }
      },
      (_) {
        allTask = allTask.where((t) => t.id != param.id).toList();

        emit(DeleteTaskSuccessState());
        emit(FetchTaskSuccessState(List.from(allTask)));
      },
    );
  }

  void filterTasks(String state) {
    selectState = state;
    if (state == "All") {
      emit(FetchTaskSuccessState(List.from(allTask)));
    } else {
      final filtered = allTask.where((t) => t.state == state).toList();
      emit(FetchTaskSuccessState(filtered));
    }
  }
}
