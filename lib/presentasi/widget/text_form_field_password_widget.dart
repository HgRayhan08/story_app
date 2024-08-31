import 'package:flutter/material.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  final String hinttext;
  final TextEditingController controller;
  final bool iconButton;
  final String title;
  final double? width;
  const TextFieldPasswordWidget({
    super.key,
    required this.hinttext,
    required this.controller,
    this.iconButton = false,
    required this.title,
    this.width = double.infinity,
  });

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: widget.width,
          child: Material(
            child: TextFormField(
              controller: widget.controller,
              obscureText: !_obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: widget.hinttext,
                suffixIcon: widget.iconButton == false
                    ? null
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                        )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
