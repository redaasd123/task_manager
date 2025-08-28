import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task_manager/feature/home/presentation/manager/home_cubit.dart';
import 'package:task_manager/feature/home/presentation/view/widget/skelton_widget.dart';

import '../../../../../core/snack_bar/custom_flush.dart';
import '../../../../../core/utils/message.dart';
import '../../../../../core/utils/styles.dart';
import 'home_item_list_view.dart';

class HomeViewBlocConsumer extends StatefulWidget {
  const HomeViewBlocConsumer({super.key});

  @override
  State<HomeViewBlocConsumer> createState() => _HomeViewBlocConsumerState();
}

class _HomeViewBlocConsumerState extends State<HomeViewBlocConsumer> {
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // ✅ HomeCubit listener
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is CreateTaskSuccessState) {
              showGreenFlush(context, taskCreatedMessage);
            } else if (state is CreateTaskFailureState) {
              //  BlocProvider.of<HomeCubit>(context).fetchTask();
              showRedFlush(
                context,
                state.errMessage.isNotEmpty
                    ? state.errMessage
                    : createTaskError,
              );
            } else if (state is EditTaskSuccessState) {
              showGreenFlush(context, taskUpdatedMessage);
            } else if (state is EditTaskFailureState) {
              //  BlocProvider.of<HomeCubit>(context).fetchTask();
              showRedFlush(
                context,
                state.errMessage.isNotEmpty ? state.errMessage : editTaskError,
              );
            } else if (state is DeleteTaskSuccessState) {
              showGreenFlush(context, taskDeletedMessage);
            } else if (state is DeleteTaskFailureState) {
              // BlocProvider.of<HomeCubit>(context).fetchTask();
              showRedFlush(
                context,
                state.errMessage.isNotEmpty
                    ? state.errMessage
                    : deleteTaskError,
              );
            } else if (state is FetchTaskFailureState) {
              showRedFlush(
                context,
                state.errMessage.isNotEmpty
                    ? state.errMessage
                    : fetchTasksError,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is FetchTaskLoadingState) {
            return const SkeletonizerWidget();
          } else if (state is CreateTaskLoadingState ||
              state is EditTaskLoadingState ||
              state is DeleteTaskLoadingState) {
            return Stack(
              children: [
                HomeItemListView(task: context.read<HomeCubit>().allTask),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          } else if (state is FetchTaskSuccessState) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text(noTasksMessage));
            }
            return HomeItemListView(task: state.tasks);
          } else if (state is FetchTaskFailureState) {
            return Center(child: Text(state.errMessage));
          } else if (state is CreateTaskFailureState ||
              state is EditTaskFailureState ||
              state is DeleteTaskFailureState) {
            return HomeItemListView(task: context.read<HomeCubit>().allTask);
          } else {
            return Center(
              child: Text(emptyStateMessage, style: Styles.textStyle30),
            );
          }
        },
      ),
    );
  }
}



