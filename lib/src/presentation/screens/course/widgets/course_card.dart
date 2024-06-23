import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class CourseCard extends StatefulWidget {
  final String image;
  final String date;
  final String title;

  final VoidCallback ontap;

  const CourseCard({
    super.key,
    required this.image,
    required this.date,
    required this.title,
    required this.ontap,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color.fromARGB(159, 0, 0, 0), blurRadius: 5),
        ],
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              widget.date,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TBTPurpleButton(
              buttonText: "Eğitime Git",
              onPressed: () {
                widget.ontap();
              })
        ],
      ),
    );
  }
}
