import 'package:flutter/material.dart';

class TextForPersonPage extends StatelessWidget {
  const TextForPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 48,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(text: "Kontrol\nSende\n"),
          TextSpan(
              text: "adım at,\n",
              style: TextStyle(color: Color.fromRGBO(153, 51, 255, 1.00))),
          TextSpan(text: "Tobeto ile \nFark yarat!"),
        ],
      ),
    );
  }
}
