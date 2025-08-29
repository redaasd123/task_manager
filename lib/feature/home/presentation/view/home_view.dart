import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/connectivity/check_internet_cubit.dart';
import 'package:task_manager/core/utils/service_locator.dart';
import 'package:task_manager/feature/home/presentation/manager/home_cubit.dart';
import 'package:task_manager/feature/home/presentation/view/widget/home_view_body.dart';

import '../../../../core/snack_bar/custom_flush.dart';
import '../../../../core/utils/message.dart';
import '../../../../core/utils/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()..fetchTask()),
        BlocProvider(create: (context) => getIt<CheckInternetCubit>()),
      ],
      child: BlocListener<CheckInternetCubit, CheckInternetState>(
        listener: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          if (state is ConnectivityDisconnected) {
            showRedFlush(context, noInternetMessage);
            return;
          } else if (state is ConnectivityConnected) {
            if (!cubit.isFirstFetch) {
              showGreenFlush(context, backOnlineMessage);
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(welcomeMessage, style: Styles.textStyle30),
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: HomeViewBody(),
        ),
      ),
    );
  }
}
