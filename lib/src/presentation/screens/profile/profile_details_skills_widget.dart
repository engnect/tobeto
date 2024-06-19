import 'package:flutter/material.dart';

class SkillsWidget extends StatelessWidget {
  final String skill;
  const SkillsWidget({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          skill,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
