import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/feature/home/presentation/manager/home_cubit.dart';

import '../../../../../core/utils/filter_button.dart';

class FilterButtonListView extends StatelessWidget {
  const FilterButtonListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> filters = ["All", "Urgent", "Completed", "Pending"];
    return SizedBox(
      height: 40,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final title = filters[index];
              return FilterButton(
                title: title,
                isSelected: cubit.selectState == title,
                onTap: () {
                  cubit.filterTasks(title);
                },
              );
            },
          );
        },
      ),
    );
  }
}
