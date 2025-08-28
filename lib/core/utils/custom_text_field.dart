import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool readOnly;
  final int maxLength;
  final int minLine;
  final bool expanded;
  final Icon icon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    required this.keyboardType,
    required this.readOnly,
    required this.maxLength,
    this.minLine = 1,
    this.expanded = false, required this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        minLines: widget.minLine,
        maxLines: null,
        readOnly: widget.readOnly,
        validator: _validator,
        style: TextStyle(color: scheme.onBackground),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          counterText: "",
          suffixIcon:widget.icon,
          labelText: widget.label,
          hintText: widget.hint,
          labelStyle: TextStyle(
            color: scheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          hintStyle: TextStyle(color: scheme.onBackground.withOpacity(0.6)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: scheme.primary),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: scheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  String? _validator(String? data) {
    final value = data?.trim() ?? '';

    if (value.isEmpty) return 'من فضلك أدخل هذا الحقل';

    if (value.length > widget.maxLength) {
      return 'عدد الأحرف لا يمكن أن يزيد عن ${widget.maxLength}';
    }

    if (widget.isPassword && value.length < 6) {
      return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
    }

    return null;
  }
}
