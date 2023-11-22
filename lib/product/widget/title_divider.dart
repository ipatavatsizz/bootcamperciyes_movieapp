import 'package:flutter/material.dart';

enum DividerAlignment { left, center, right }

class TitleDivider extends StatelessWidget {
  TitleDivider({
    super.key,
    required this.title,
    this.alignment = DividerAlignment.center,
    this.style,
  });

  final String title;
  final TextStyle? style;
  final DividerAlignment alignment;

  @override
  Widget build(BuildContext context) {
    Widget left = Flexible(
      child: Divider(
        endIndent: 10,
        thickness: 2,
        color: Colors.black,
      ),
    );
    Widget center = Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: style ?? TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );
    Widget right = Flexible(
      child: Divider(
        indent: 10,
        thickness: 2,
        color: Colors.black,
      ),
    );

    switch (alignment) {
      case DividerAlignment.left:
        left = SizedBox(
          width: 70,
          child: Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
            color: Colors.black,
          ),
        );
        break;
      case DividerAlignment.center:
        break;
      case DividerAlignment.right:
        right = SizedBox(
          width: 70,
          child: Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
            color: Colors.black,
          ),
        );
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        left,
        center,
        right,
      ],
    );
  }
}
