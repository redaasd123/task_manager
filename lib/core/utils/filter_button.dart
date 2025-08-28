import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  Color _getBackgroundColor() {
    if (isSelected) {
      switch (title) {
        case "Urgent":
          return Colors.red.shade400;
        case "Completed":
          return Colors.green.shade400;
        case "Pending":
          return Colors.orange.shade400;
        default:
          return Colors.grey.shade600;
      }
    } else {
      return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (isSelected) return Colors.white;
    switch (title) {
      case "Urgent":
        return Colors.red.shade400;
      case "Completed":
        return Colors.green.shade400;
      case "Pending":
        return Colors.orange.shade400;
      default:
        return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      splashColor: Colors.grey.shade300,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _getTextColor(),
          ),
        ),
      ),
    );
  }
}
