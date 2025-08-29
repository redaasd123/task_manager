import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';
import 'package:task_manager/feature/home/presentation/manager/home_cubit.dart';
import 'package:task_manager/feature/home/presentation/view/widget/show_create_bottom_sheet.dart';

import '../../../../../core/utils/message.dart';
import 'home_view_item.dart';

class HomeItemListView extends StatefulWidget {
  const HomeItemListView({super.key, required this.task});

  final List<TaskEntity> task;

  @override
  State<HomeItemListView> createState() => _HomeItemListViewState();
}

class _HomeItemListViewState extends State<HomeItemListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.task.length,
      itemBuilder: (context, index) {
        final item = widget.task[index];
        return Dismissible(
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(deleteConfirmationTitle),
                  content: const Text(deleteConfirmationContent),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text(cancelText),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        deleteText,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },

          key: Key(item.id),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            BlocProvider.of<HomeCubit>(
              context,
            ).deleteTask(DeleteTaskParam(id: item.id));
          },
          child: GestureDetector(
            onTap: () async {
              final data = await showCreateBottomSheet(context, editTask, item);
              if (data != null) {
                BlocProvider.of<HomeCubit>(context).editTask(
                  EditTaskParam(
                    id: item.id,
                    title: data.title,
                    state: data.state,
                    desc: data.desc,
                  ),
                );
              }
            },
            child: HomeViewItem(task: widget.task[index]),
          ),
        );
      },
    );
  }
}
