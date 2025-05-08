import 'package:flutter/material.dart';

class VerticalIconText extends StatelessWidget {
  const VerticalIconText({
    super.key,
    required this.icon,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.onTap,
  });

  final Icon icon;
  final String title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: icon,
            ),
          ),

          /// Text
          const SizedBox(height: 16.0 / 2),
          SizedBox(width: 65, child: Center(child: Text(title, style: TextStyle(fontSize: 12, color: textColor), maxLines: 1)))
        ],
      ),
    );
  }
}