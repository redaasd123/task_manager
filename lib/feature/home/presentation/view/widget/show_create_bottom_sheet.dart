
import 'package:flutter/material.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';

import 'bottom_sheet.dart';

Future<CreateTaskParam?> showCreateBottomSheet(BuildContext context,String text,[TaskEntity? taskEntity]) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      child: CreateBottomSheet(taskEntity: taskEntity, text: text),
    ),
  );
}