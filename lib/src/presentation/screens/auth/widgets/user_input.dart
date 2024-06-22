import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';

class UserInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const UserInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

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
          controller: controller,
          keyboardType: TextInputType.name,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            color: Color.fromRGBO(60, 60, 60, 1),
          ),
          decoration: InputDecoration(
            prefixIcon: Image.asset(Assets.imageUser),
            hintText: hintText,
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
