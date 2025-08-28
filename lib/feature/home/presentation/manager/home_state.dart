part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {}

// =======================================
// Fetch States
final class FetchTaskInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class FetchTaskLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class FetchTaskFailureState extends HomeState {
  final String errMessage;

  FetchTaskFailureState({required this.errMessage});

  FetchTaskFailureState copyWith({String? errMessage}) {
    return FetchTaskFailureState(
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [errMessage];
}

final class FetchTaskSuccessState extends HomeState {
  final List<TaskEntity> tasks;

  FetchTaskSuccessState(this.tasks);

  FetchTaskSuccessState copyWith({List<TaskEntity>? tasks}) {
    return FetchTaskSuccessState(
      tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [tasks];
}

// =======================================
// Create States
final class CreateTaskLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class CreateTaskFailureState extends HomeState {
  final String errMessage;

  CreateTaskFailureState({required this.errMessage});

  CreateTaskFailureState copyWith({String? errMessage}) {
    return CreateTaskFailureState(
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [errMessage];
}

final class CreateTaskSuccessState extends HomeState {
  CreateTaskSuccessState();

  @override
  List<Object?> get props => [];
}

// =======================================
// Edit States
final class EditTaskLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class EditTaskFailureState extends HomeState {
  final String errMessage;

  EditTaskFailureState({required this.errMessage});

  EditTaskFailureState copyWith({String? errMessage}) {
    return EditTaskFailureState(
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [errMessage];
}

final class EditTaskSuccessState extends HomeState {
  EditTaskSuccessState();

  @override
  List<Object?> get props => [];
}

// =======================================
// Delete States
final class DeleteTaskLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class DeleteTaskFailureState extends HomeState {
  final String errMessage;

  DeleteTaskFailureState({required this.errMessage});

  DeleteTaskFailureState copyWith({String? errMessage}) {
    return DeleteTaskFailureState(
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [errMessage];
}

final class DeleteTaskSuccessState extends HomeState {
  DeleteTaskSuccessState();

  @override
  List<Object?> get props => [];
}
