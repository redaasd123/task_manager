import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:task_manager/feature/home/data/repo_impl/home_repo_impl.dart';
import 'package:task_manager/feature/home/domain/repo/home_repo.dart';
import 'package:task_manager/feature/home/domain/use_case/create_task_use_case.dart';
import 'package:task_manager/feature/home/domain/use_case/delete_task_use_case.dart';
import 'package:task_manager/feature/home/domain/use_case/edit_task_use_case.dart';
import 'package:task_manager/feature/home/domain/use_case/fetch_task_use_case.dart';
import 'package:task_manager/feature/home/presentation/manager/home_cubit.dart';

import '../connectivity/check_internet_cubit.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(homeRemoteDataSource: getIt.get(), getIt.get()),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<FetchTaskUseCase>(
    () => FetchTaskUseCase(homeRepo: getIt.get()),
  );
  getIt.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(homeRepo: getIt.get()),
  );
  getIt.registerLazySingleton<EditTaskUseCase>(
    () => EditTaskUseCase(homeRepo: getIt.get()),
  );
  getIt.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(homeRepo: getIt.get()),
  );
  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(getIt.get(), getIt.get(), getIt.get(), getIt.get()),
  );

  getIt.registerLazySingleton<CheckInternetCubit>(
    () => CheckInternetCubit(getIt.get(), getIt.get()),
  );
}
