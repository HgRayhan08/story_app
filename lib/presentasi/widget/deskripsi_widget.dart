import 'package:flutter/material.dart';

class DeskripsiWidget extends StatelessWidget {
  const DeskripsiWidget({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Text(
            "Name :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
