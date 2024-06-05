import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class TBTInfoCard extends StatelessWidget {
  final String content;
  final String count;
  final Icon icon;
  final int r;
  final int g;
  final int b;

  const TBTInfoCard({
    super.key,
    required this.content,
    required this.count,
    required this.icon,
    required this.r,
    required this.g,
    required this.b,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width - 100,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(90),
        ),
        border: GradientBoxBorder(
          width: 5,
          gradient: SweepGradient(
            startAngle: 0.7853981634, //rad türünden 45 derece
            endAngle: 3.926990817, //rad türünden 225 derece
            colors: [
              Colors.transparent,
              Color.fromRGBO(r, g, b, 1),
              Colors.transparent,
            ],
            stops: const [0.20, 0.5, 0.8],
            tileMode: TileMode.mirror, // simetrik yansıtmak için
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromRGBO(r, g, b, 0.7),
              minRadius: 50,
              child: Icon(
                color: Color.fromRGBO(r, g, b, 1),
                icon.icon,
                size: 50,
              ),
            ),
            Text(
              count,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 70,
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(r, g, b, 1),
              ),
            ),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 101, 95, 95),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
