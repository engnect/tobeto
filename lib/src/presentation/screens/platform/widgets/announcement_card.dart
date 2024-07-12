import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/models/announcement_model.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcementModel;
  const AnnouncementCard({super.key, required this.announcementModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 6),
                child: Text(
                  'Duyuru',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, right: 6),
                child: Text(
                  'İstanbul Kodluyor',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              announcementModel.announcementTitle,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 6),
                    child: Icon(Icons.calendar_month_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      DateFormat('dd/MM/yyyy')
                          .format(announcementModel.announcementDate),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  _showPopup(context, announcementModel.announcementTitle,
                      announcementModel.announcementContent);
                },
                child: Text(
                  "Devamını Oku",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
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

void _showPopup(BuildContext context, title, content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          title.toString().toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            content,
            style: TextStyle(
              fontFamily: "Poppins",
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Kapat',
              style: TextStyle(
                fontFamily: "Poppins",
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
