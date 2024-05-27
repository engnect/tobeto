import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsImageCard extends StatelessWidget {
  final String photo;
  final String content;
  const AboutUsImageCard({
    super.key,
    required this.photo,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(photo),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 35),
            child: Text(
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(255, 129, 129, 129),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              content,
            ),
          ),
        ],
      ),
    );
  }
}
