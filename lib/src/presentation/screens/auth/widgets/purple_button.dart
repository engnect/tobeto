import 'package:flutter/material.dart';

class TBTPurpleButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  const TBTPurpleButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 153, 51, 255),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
      ),
    );
  }
}
