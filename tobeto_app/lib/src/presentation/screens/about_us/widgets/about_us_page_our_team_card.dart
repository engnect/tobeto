import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AboutUsOurTeamCard extends StatelessWidget {
  final String teamPhoto;
  final String teamName;
  final String teamTitle;
  const AboutUsOurTeamCard({
    super.key,
    required this.teamPhoto,
    required this.teamName,
    required this.teamTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(
            Radius.circular(90),
          ),
          border: const GradientBoxBorder(
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
              tileMode: TileMode.mirror,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(teamPhoto),
                radius: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                textAlign: TextAlign.center,
                teamName,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                textAlign: TextAlign.center,
                teamTitle,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
