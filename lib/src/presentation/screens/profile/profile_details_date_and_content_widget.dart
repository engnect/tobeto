import 'package:flutter/material.dart';

class DateAndContentWidget extends StatelessWidget {
  final String date;
  final String content;
  const DateAndContentWidget({
    super.key,
    required this.date,
    required this.content,
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Color.fromRGBO(111, 111, 111, 1)),
            ),
            Text(
              content,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
