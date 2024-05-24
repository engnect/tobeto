import 'package:flutter/material.dart';

class ForSectorCard extends StatelessWidget {
  final String header;
  final String content;
  final Color color;
  final List<ForSectorCardContent> cardContentList;
  const ForSectorCard({
    super.key,
    required this.header,
    required this.content,
    required this.color,
    required this.cardContentList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: color,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Column(
            children: cardContentList,
          )
        ],
      ),
    );
  }
}

class ForSectorCardContent extends StatelessWidget {
  final String header;
  final String content;
  const ForSectorCardContent({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(255, 255, 255, 0.92),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
