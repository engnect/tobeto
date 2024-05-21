import 'package:flutter/material.dart';

class TBTInputField extends StatefulWidget {
  final String hintText;
  final bool? isObscure;
  final TextEditingController controller;
  final Function(String?) onSaved;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;

  const TBTInputField({
    super.key,
    required this.hintText,
    this.isObscure = false,
    required this.controller,
    required this.onSaved,
    required this.keyboardType,
    this.readOnly,
    this.maxLines,
    this.minLines,
  });

  @override
  State<TBTInputField> createState() => _TBTInputFieldState();
}

class _TBTInputFieldState extends State<TBTInputField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        maxLines: widget.maxLines,
        minLines: widget.minLines,

        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isObscure == true
              ? showPassword
                  ? IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    )
              : null,
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
        ),
        autocorrect: false,
        obscureText: showPassword,
        // onSaved: onSaved,
      ),
    );
  }
}
