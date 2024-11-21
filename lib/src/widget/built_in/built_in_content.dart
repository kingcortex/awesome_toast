
import 'package:flutter/material.dart';

class BuiltInContent extends StatelessWidget {
  final Widget title;
  final Widget? description;
  const BuiltInContent({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        if (description != null) ...[description!],
      ],
    );
  }
}
