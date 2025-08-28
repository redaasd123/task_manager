import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


Future<void> showGreenFlush(BuildContext context, String message) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final overlayCtx = Navigator.of(
      context,
      rootNavigator: true,
    ).overlay!.context;
    final colorScheme = Theme.of(context).colorScheme;

    Flushbar<void>(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: colorScheme.secondary,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(20),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      duration: const Duration(seconds: 4),
      messageText: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      mainButton: TextButton(
        onPressed: () => Navigator.of(overlayCtx).pop(),
        child: const Text(
          'حسنًا',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
    ).show(overlayCtx);
  });
}

Future<void> showRedFlush(BuildContext context, String message) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final overlayCtx = Navigator.of(
      context,
      rootNavigator: true,
    ).overlay!.context;
    final colorScheme = Theme.of(context).colorScheme;

    Flushbar<void>(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: colorScheme.error,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(20),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      duration: const Duration(seconds: 4),
      messageText: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      mainButton: TextButton(
        onPressed: () => Navigator.of(overlayCtx).pop(),
        child: Text('Cansel',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
    ).show(overlayCtx);
  });
}
