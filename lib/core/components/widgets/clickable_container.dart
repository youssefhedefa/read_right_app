import 'package:flutter/material.dart';

class ClickableContainer extends StatelessWidget {
  const ClickableContainer({super.key, required this.text, required this.onTap, required this.icon});

  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                )
            ),
          ],
        ),
      ),
    );
  }
}
