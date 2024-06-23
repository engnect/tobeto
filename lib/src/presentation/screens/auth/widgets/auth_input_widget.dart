import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final String assetImagePath;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscure;
  const AuthInput({
    super.key,
    required this.assetImagePath,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.isObscure,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(11),
          ),
        ),
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            color: Color.fromRGBO(60, 60, 60, 1),
          ),
          autocorrect: false,
          obscureText: widget.isObscure != null ? !showPassword : showPassword,
          decoration: InputDecoration(
            prefixIcon: Image.asset(widget.assetImagePath),
            suffixIcon: widget.isObscure == null
                ? null
                : showPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility_off_outlined,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility_outlined,
                        ),
                      ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(129, 129, 129, 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(138, 138, 138, 0.4),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Color.fromRGBO(153, 51, 255, 0.4),
                width: 4,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(129, 129, 129, 1),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
