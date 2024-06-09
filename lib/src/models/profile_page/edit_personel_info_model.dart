import 'dart:io';

class UserProfile {
  final String name;
  final String surname;
  final String phoneNumber;
  final DateTime? birthDate;
  final String email;
  final String? gender;
  final String? militaryStatus;
  final String? disabilityStatus;
  final String? country;
  final String? cityId;
  final String? cityName;
  final String? districtId;
  final String? districtName;
  final String street;
  final String aboutMe;
  final File? profileImage;

  UserProfile({
    required this.name,
    required this.surname,
    required this.phoneNumber,
    this.birthDate,
    required this.email,
    this.gender,
    this.militaryStatus,
    this.disabilityStatus,
    this.country,
    this.cityId,
    this.cityName,
    this.districtId,
    this.districtName,
    required this.street,
    required this.aboutMe,
    this.profileImage,
  });
}
