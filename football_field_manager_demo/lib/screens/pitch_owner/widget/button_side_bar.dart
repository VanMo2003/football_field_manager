import 'package:flutter/material.dart';

class NewRow extends StatelessWidget {
  const NewRow({
    super.key,
    this.icon,
    this.title,
    required this.onTap,
    this.isColor = false,
  });

  final IconData? icon;
  final String? title;
  final Function() onTap;
  final bool isColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: isColor ? Colors.white60 : Colors.white,
            size: 28,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? '',
            style: const TextStyle(color: Colors.white60, fontSize: 20),
          )
        ],
      ),
    );
  }
}
