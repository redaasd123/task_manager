import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/feature/home/domain/param.dart';
import 'package:task_manager/feature/home/presentation/manager/home_cubit.dart';
import 'package:task_manager/feature/home/presentation/view/widget/filter_button_list_view.dart';
import 'package:task_manager/feature/home/presentation/view/widget/show_create_bottom_sheet.dart';

import 'home_item_list_view.dart';
import 'home_view_bloc_consumer.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final data = await showCreateBottomSheet(context,'Create Task');
          if (data != null) {
            BlocProvider.of<HomeCubit>(context)
                .createTask(
                CreateTaskParam(
                    title: data.title, state: data.state, desc: data.desc));
          }
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: FilterButtonListView(),
          ),
          const SizedBox(height: 12),
          const Expanded(child: HomeViewBlocConsumer()),
        ],
      ),
    );
  }
}

