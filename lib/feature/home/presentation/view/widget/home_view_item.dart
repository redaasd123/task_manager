import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/styles.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';


class HomeViewItem extends StatelessWidget {
  const HomeViewItem({super.key, required this.task});

  final TaskEntity task;

  Color _getStateColor() {
    switch (task.state) {
      case "Urgent": return Colors.red.shade600;
      case "Completed": return Colors.green.shade600;
      case "Pending": return Colors.orange.shade600;
      default: return Colors.grey.shade600;
    }
  }

  Color _getCardColor() {
    switch (task.state) {
      case "Urgent": return Colors.red.shade50;
      case "Completed": return Colors.green.shade50;
      case "Pending": return Colors.orange.shade50;
      default: return Color(0xFFF8F6FA);
    }
  }

  IconData _getStateIcon() {
    switch (task.state) {
      case "Urgent": return Icons.priority_high;
      case "Completed": return Icons.check_circle;
      case "Pending": return Icons.hourglass_bottom;
      default: return Icons.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: _getCardColor(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getStateIcon(), color: _getStateColor(), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    task.title,
                    style: Styles.textStyle20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(task.desc, style: TextStyle(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
              DateFormat('EEEE, d MMMM yyyy – hh:mm a').format(task.createAt),
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStateColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.state,
                    style: TextStyle(color: _getStateColor(), fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
