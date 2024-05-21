import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final String header;
  final String content;
  final Image image;
  const CarouselCard({
    super.key,
    required this.header,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
              child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(155, 39, 176, 0.5),
                      blurRadius: 13,
                    ),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                header,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                maxLines: 8,
                overflow: TextOverflow.fade,
                content,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    color: Color.fromARGB(255, 79, 75, 104)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
