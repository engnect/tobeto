import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  final String language;
  final String languageLevel;
  const LanguageWidget({
    super.key,
    required this.language,
    required this.languageLevel,
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
      child: Row(
        children: [
          const Icon(
            Icons.language_outlined,
            color: Color.fromRGBO(111, 111, 111, 1),
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                  ),
                ),
                Text(
                  languageLevel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Color.fromRGBO(111, 111, 111, 1)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
