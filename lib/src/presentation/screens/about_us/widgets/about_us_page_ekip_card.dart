import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class EkipCard extends StatelessWidget {
  final String photo;
  final String name;
  final String jop;
  const EkipCard({
    super.key,
    required this.photo,
    required this.name,
    required this.jop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        // height: MediaQuery.of(context).size.width - 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(90),
          ),
          border: GradientBoxBorder(
            width: 5,
            gradient: SweepGradient(
              startAngle: 0.7853981634, //rad türünden 45 derece
              endAngle: 3.926990817, //rad türünden 225 derece
              colors: [
                Colors.transparent,
                Color.fromRGBO(186, 119, 252, 1),
                Colors.transparent,
              ],
              stops: [0.20, 0.5, 0.8],
              tileMode: TileMode.mirror, // simetrik yansıtmak için
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(photo),
                radius: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                textAlign: TextAlign.center,
                name,
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                textAlign: TextAlign.center,
                jop,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    color: Color.fromRGBO(165, 165, 165, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
