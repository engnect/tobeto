import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tobeto/src/models/avatar_model.dart';

class StudentCommentCard extends StatefulWidget {
  final AvatarModel model;
  const StudentCommentCard({
    super.key,
    required this.model,
  });

  @override
  State<StudentCommentCard> createState() => _StudentCommentCardState();
}

class _StudentCommentCardState extends State<StudentCommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 5), //Ekran ile card arasında ki mesafe için
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(90),
        ),
        border: const GradientBoxBorder(
          width: 5, //border kalınlığı
          gradient: SweepGradient(
            startAngle: 2.3561944902, //rad türünden 135 derece
            endAngle: 5.4977871438, //rad türünden 315 derece
            colors: [
              Colors.transparent,
              Color.fromRGBO(110, 37, 132, 1),
              Colors.transparent,
            ],
            stops: [0.15, 0.5, 0.88], //renk dağılımını ayarlamak için
            tileMode: TileMode.mirror, // simetrik yansıtmak için
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 18),
                widget.model.comment,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
              child: CircleAvatar(
                backgroundImage: AssetImage(widget.model.avatar),
                radius: 45,
                backgroundColor: widget.model.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                widget.model.studentname,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "Öğrenci",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
