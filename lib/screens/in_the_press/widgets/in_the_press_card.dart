import 'package:flutter/material.dart';

class InThePressCard extends StatefulWidget {
  final String image;
  final String date;
  final String title;
  final String content;
  final VoidCallback ontap;

  const InThePressCard({
    super.key,
    required this.image,
    required this.date,
    required this.title,
    required this.content,
    required this.ontap,
  });

  @override
  State<InThePressCard> createState() => _InThePressCardState();
}

class _InThePressCardState extends State<InThePressCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        widget.ontap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color.fromARGB(159, 0, 0, 0), blurRadius: 5),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.asset(widget.image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                widget.date,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.content,
                  maxLines: _isExpanded ? null : 4,
                  overflow: _isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
