import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/models/certificate_model.dart';
import 'package:tobeto/src/models/education_model.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/language_model.dart';
import 'package:tobeto/src/models/skill_model.dart';
import 'package:tobeto/src/models/social_media_model.dart';

class UserModel {
  final String userId;
  final String userName;
  final String userSurname;
  final String userEmail;
  final String? userAvatarUrl;
  final String? userPhoneNumber;
  final DateTime? userBirthDate;

  //enum
  final UserRank? userRank;

  final DateTime? userCreatedAt;
  final String? gender;
  final String? militaryStatus;
  final String? disabilityStatus;
  final String? aboutMe;
  final List<LanguageModel>? languageList;
  final List<SocialMediaModel>? socialMediaList;
  final List<SkillModel>? skillsList;
  final List<ExperienceModel>? experiencesList;
  final List<EducationModel>? schoolsList;
  final List<CertificateModel>? certeficatesList;
  UserModel({
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    this.userAvatarUrl,
    this.userPhoneNumber,
    this.userBirthDate,
    this.userRank,
    this.userCreatedAt,
    this.gender,
    this.militaryStatus,
    this.disabilityStatus,
    this.aboutMe,
    this.languageList,
    this.socialMediaList,
    this.skillsList,
    this.experiencesList,
    this.schoolsList,
    this.certeficatesList,
  });

  UserModel copyWith({
    String? userId,
    String? userName,
    String? userSurname,
    String? userEmail,
    String? userAvatarUrl,
    String? userPhoneNumber,
    DateTime? userBirthDate,
    UserRank? userRank,
    DateTime? userCreatedAt,
    String? gender,
    String? militaryStatus,
    String? disabilityStatus,
    String? aboutMe,
    List<LanguageModel>? languageList,
    List<SocialMediaModel>? socialMediaList,
    List<SkillModel>? skillsList,
    List<ExperienceModel>? experiencesList,
    List<EducationModel>? schoolsList,
    List<CertificateModel>? certeficatesList,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userSurname: userSurname ?? this.userSurname,
      userEmail: userEmail ?? this.userEmail,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
      userBirthDate: userBirthDate ?? this.userBirthDate,
      userRank: userRank ?? this.userRank,
      userCreatedAt: userCreatedAt ?? this.userCreatedAt,
      gender: gender ?? this.gender,
      militaryStatus: militaryStatus ?? this.militaryStatus,
      disabilityStatus: disabilityStatus ?? this.disabilityStatus,
      aboutMe: aboutMe ?? this.aboutMe,
      languageList: languageList ?? this.languageList,
      socialMediaList: socialMediaList ?? this.socialMediaList,
      skillsList: skillsList ?? this.skillsList,
      experiencesList: experiencesList ?? this.experiencesList,
      schoolsList: schoolsList ?? this.schoolsList,
      certeficatesList: certeficatesList ?? this.certeficatesList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userSurname': userSurname,
      'userEmail': userEmail,
      'userAvatarUrl': userAvatarUrl,
      'userPhoneNumber': userPhoneNumber,
      'userBirthDate': userBirthDate,
      'userRank': userRank?.name,
      'userCreatedAt': userCreatedAt,
      'gender': gender,
      'militaryStatus': militaryStatus,
      'disabilityStatus': disabilityStatus,
      'aboutMe': aboutMe,
      'languageList': languageList?.map((x) => x.toMap()).toList(),
      'socialMediaList': socialMediaList?.map((x) => x.toMap()).toList(),
      'skillsList': skillsList?.map((x) => x.toMap()).toList(),
      'experiencesList': experiencesList?.map((x) => x.toMap()).toList(),
      'schoolsList': schoolsList?.map((x) => x.toMap()).toList(),
      'certeficatesList': certeficatesList?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userSurname: map['userSurname'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userAvatarUrl: map['userAvatarUrl'],
      userPhoneNumber: map['userPhoneNumber'],
      userBirthDate: map['userBirthDate'].toDate(),
      userRank: UserRankExtension.fromName(map['userRank']),
      userCreatedAt: map['userCreatedAt'].toDate(),
      gender: map['gender'],
      militaryStatus: map['militaryStatus'],
      disabilityStatus: map['disabilityStatus'],
      aboutMe: map['aboutMe'],
      languageList: map['languageList'] != null
          ? List<LanguageModel>.from(
              map['languageList']?.map((x) => LanguageModel.fromMap(x)))
          : null,
      socialMediaList: map['socialMediaList'] != null
          ? List<SocialMediaModel>.from(
              map['socialMediaList']?.map((x) => SocialMediaModel.fromMap(x)))
          : null,
      skillsList: map['skillsList'] != null
          ? List<SkillModel>.from(
              map['skillsList']?.map((x) => SkillModel.fromMap(x)))
          : null,
      experiencesList: map['experiencesList'] != null
          ? List<ExperienceModel>.from(
              map['experiencesList']?.map((x) => ExperienceModel.fromMap(x)))
          : null,
      schoolsList: map['schoolsList'] != null
          ? List<EducationModel>.from(
              map['schoolsList']?.map((x) => EducationModel.fromMap(x)))
          : null,
      certeficatesList: map['certeficatesList'] != null
          ? List<CertificateModel>.from(
              map['certeficatesList']?.map((x) => CertificateModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, userSurname: $userSurname, userEmail: $userEmail, userAvatarUrl: $userAvatarUrl, userPhoneNumber: $userPhoneNumber, userBirthDate: $userBirthDate, userRank: $userRank, userCreatedAt: $userCreatedAt, gender: $gender, militaryStatus: $militaryStatus, disabilityStatus: $disabilityStatus, aboutMe: $aboutMe, languageList: $languageList, socialMediaList: $socialMediaList, skillsList: $skillsList, experiencesList: $experiencesList, schoolsList: $schoolsList, certeficatesList: $certeficatesList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.userName == userName &&
        other.userSurname == userSurname &&
        other.userEmail == userEmail &&
        other.userAvatarUrl == userAvatarUrl &&
        other.userPhoneNumber == userPhoneNumber &&
        other.userBirthDate == userBirthDate &&
        other.userRank == userRank &&
        other.userCreatedAt == userCreatedAt &&
        other.gender == gender &&
        other.militaryStatus == militaryStatus &&
        other.disabilityStatus == disabilityStatus &&
        other.aboutMe == aboutMe &&
        listEquals(other.languageList, languageList) &&
        listEquals(other.socialMediaList, socialMediaList) &&
        listEquals(other.skillsList, skillsList) &&
        listEquals(other.experiencesList, experiencesList) &&
        listEquals(other.schoolsList, schoolsList) &&
        listEquals(other.certeficatesList, certeficatesList);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userSurname.hashCode ^
        userEmail.hashCode ^
        userAvatarUrl.hashCode ^
        userPhoneNumber.hashCode ^
        userBirthDate.hashCode ^
        userRank.hashCode ^
        userCreatedAt.hashCode ^
        gender.hashCode ^
        militaryStatus.hashCode ^
        disabilityStatus.hashCode ^
        aboutMe.hashCode ^
        languageList.hashCode ^
        socialMediaList.hashCode ^
        skillsList.hashCode ^
        experiencesList.hashCode ^
        schoolsList.hashCode ^
        certeficatesList.hashCode;
  }
}
