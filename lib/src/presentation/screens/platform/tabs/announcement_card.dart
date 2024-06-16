import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/models/announcement_model.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcementModel;
  const AnnouncementCard({super.key, required this.announcementModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 110,
      width: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border(
          left: BorderSide(
            width: 5,
            color: Colors.green,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Duyuru'),
              Text('İstanbul Kodluyor'),
            ],
          ),
          Text(announcementModel.announcementTitle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Text(
                    DateFormat('dd/MM/yyyy')
                        .format(announcementModel.announcementDate),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Devamını Oku",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
