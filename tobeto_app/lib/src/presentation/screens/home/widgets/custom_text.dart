import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TBTCustomText extends StatelessWidget {
  const TBTCustomText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontFamily: "Poppins", fontSize: 36),
        children: <TextSpan>[
          TextSpan(
            text: "B",
            style: TextStyle(
              color: Color.fromRGBO(96, 73, 133, 1.00),
            ),
          ),
          TextSpan(
            text: "i",
            style: TextStyle(
              color: Color.fromRGBO(102, 77, 139, 1.00),
            ),
          ),
          TextSpan(
            text: "r",
            style: TextStyle(
              color: Color.fromRGBO(106, 79, 141, 1.00),
            ),
          ),
          TextSpan(
            text: "l",
            style: TextStyle(
              color: Color.fromRGBO(110, 79, 144, 1.00),
            ),
          ),
          TextSpan(
            text: "i",
            style: TextStyle(
              color: Color.fromRGBO(109, 81, 144, 1.00),
            ),
          ),
          TextSpan(
            text: "k",
            style: TextStyle(
              color: Color.fromRGBO(116, 82, 148, 1.00),
            ),
          ),
          TextSpan(
            text: "t",
            style: TextStyle(
              color: Color.fromRGBO(119, 85, 151, 1.00),
            ),
          ),
          TextSpan(
            text: "e",
            style: TextStyle(
              color: Color.fromRGBO(126, 88, 157, 1.00),
            ),
          ),
          TextSpan(
            text: " ",
            style: TextStyle(
              color: Color.fromRGBO(110, 37, 132, 1),
            ),
          ),
          TextSpan(
            text: "B",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(129, 91, 162, 1.00),
            ),
          ),
          TextSpan(
            text: "ü",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(136, 97, 170, 1.00),
            ),
          ),
          TextSpan(
            text: "y",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(136, 103, 175, 1.00),
            ),
          ),
          TextSpan(
            text: "ü",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(140, 114, 184, 1.00),
            ),
          ),
          TextSpan(
            text: "y",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(141, 117, 184, 1.00),
            ),
          ),
          TextSpan(
            text: "o",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(146, 127, 189, 1.00),
            ),
          ),
          TextSpan(
            text: "r",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(144, 131, 190, 1.00),
            ),
          ),
          TextSpan(
            text: "u",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(148, 138, 190, 1.00),
            ),
          ),
          TextSpan(
            text: "z",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(148, 145, 190, 1.00),
            ),
          ),
          TextSpan(
            text: "!",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(148, 151, 190, 1.00),
            ),
          ),
        ],
      ),
    );
  }
}
