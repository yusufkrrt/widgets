import 'package:flutter/material.dart';

enum DialogState { loading, success, error }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.state,
    required this.message,
    this.onDismiss,
    super.key,
  });

  final DialogState state;
  final String message;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state == DialogState.loading)
              const CircularProgressIndicator(color: Color(0xFFB71C1C))
            else
              Icon(
                state == DialogState.success
                    ? Icons.check_circle_outline
                    : Icons.error_outline,
                color: state == DialogState.success
                    ? Colors.green
                    : const Color(0xFFB71C1C),
                size: 48,
              ),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            if (state != DialogState.loading && onDismiss != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onDismiss,
                child: const Text('Tamam'),
              ),
            ],
          ],
        ),
      );
}
