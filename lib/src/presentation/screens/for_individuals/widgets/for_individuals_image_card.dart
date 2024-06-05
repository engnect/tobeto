import 'package:flutter/material.dart';

class ForIndividualsImageCard extends StatelessWidget {
  final String photo;
  final String title;
  final String content;
  const ForIndividualsImageCard({
    super.key,
    required this.photo,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              title,
              style: const TextStyle(
                color: Color.fromRGBO(110, 110, 110, 1),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              style: const TextStyle(
                color: Color.fromARGB(255, 131, 131, 131),
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              content,
            ),
          ),
        ],
      ),
    );
  }
}
