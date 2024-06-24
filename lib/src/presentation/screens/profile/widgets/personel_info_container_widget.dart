import 'package:flutter/material.dart';


class PersonalInfoContainer extends StatelessWidget {
  final String birthDate;
  final String city;
  final String district;
  final String phoneNumber;
  final String email;
  final String gender;
  final String militaryStatus;
  final String disabilityStatus;

  PersonalInfoContainer({
    required this.birthDate,
    required this.city,
    required this.district,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.militaryStatus,
    required this.disabilityStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kişisel Bilgiler",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSecondary,
            thickness: 1,
            endIndent: 10,
          ),
          Text(
            "Doğum Tarihi",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              birthDate,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            "Adres",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "$city - $district",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            "Telefon Numarası",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              phoneNumber,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            "E-Posta Adresi",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              email,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            "Cinsiyet",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              gender,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            "Askerlik Durumu",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              militaryStatus,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            "Engellilik Durumu",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              disabilityStatus,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
