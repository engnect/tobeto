import 'package:flutter/material.dart';

class CommunicationInfo extends StatelessWidget {
  final String headerinfo;
  final String info;
  const CommunicationInfo({
    super.key,
    required this.headerinfo,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(214, 214, 214, 1)))),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    headerinfo,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    info,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      color: Color.fromRGBO(82, 82, 82, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
