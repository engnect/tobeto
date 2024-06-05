import 'package:flutter/material.dart';

class TBTPurpleCard extends StatelessWidget {
  final String cardText;
  final VoidCallback onPressed;
  const TBTPurpleCard({
    super.key,
    required this.cardText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.01, 1.0],
          colors: [
            Color.fromARGB(255, 174, 151, 243),
            Color.fromARGB(255, 29, 11, 140),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text(
              cardText,
              style: const TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 153, 51, 255),
                  ),
                ),
                onPressed: onPressed,
                child: const Text(
                  "Başla",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
