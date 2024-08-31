import 'package:flutter/material.dart';

class DeskripsiWidget extends StatelessWidget {
  const DeskripsiWidget({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Name :",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(data),
      ],
    );
  }
}
