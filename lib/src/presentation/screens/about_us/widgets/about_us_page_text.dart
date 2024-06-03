import 'package:flutter/material.dart';

class AboutUsText extends StatelessWidget {
  const AboutUsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: "Yeni Nesil \nMesleklere,\nYeni Nesil\n"),
            TextSpan(
                text: '"Platform!"',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Color.fromARGB(255, 153, 51, 255),
                ))
          ]),
    );
  }
}
