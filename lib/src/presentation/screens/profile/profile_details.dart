import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/domain/repositories/certificate_repository.dart';
import 'package:tobeto/src/domain/repositories/education_repository.dart';
import 'package:tobeto/src/domain/repositories/experience_repository.dart';
import 'package:tobeto/src/domain/repositories/language_repository.dart';
import 'package:tobeto/src/domain/repositories/skill_repository.dart';
import 'package:tobeto/src/domain/repositories/social_media_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/certificate_model.dart';
import 'package:tobeto/src/models/education_model.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/language_model.dart';
import 'package:tobeto/src/models/skill_model.dart';
import 'package:tobeto/src/models/social_media_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/end_drawer.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_date_and_content_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_language_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_skills_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';

class ProfilDetails extends StatefulWidget {
  const ProfilDetails({super.key});

  @override
  State<ProfilDetails> createState() => _ProfilDetailsState();
}

class _ProfilDetailsState extends State<ProfilDetails> {
  UserRepository? userRepository = UserRepository();
  UserModel? _user;
  LanguageRepository? languageRepository = LanguageRepository();
  List<LanguageModel>? _languages;
  CertificateRepository? certificateRepository = CertificateRepository();
  List<CertificateModel>? _certificate;
  ExperienceRepository? experienceRepository = ExperienceRepository();
  List<ExperienceModel>? _exp;
  EducationRepository? educationRepository = EducationRepository();
  List<EducationModel>? _edc;
  SocialMediaRepository socialMediaRepository = SocialMediaRepository();
  List<SocialMediaModel>? _scl;
  SkillRepository? skillRepository = SkillRepository();
  List<SkillModel>? _skll;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    UserModel? user = await userRepository?.getCurrentUser();
    setState(() {
      _user = user;
    });
    if (_user != null) {
      _loadUserLanguages();
      _loadUserCertificate();
      _loadUserExperience();
      _loadUserEducation();
      _loadUserSocialMedia();
      _loadUserSkill();
    }
  }

  void _loadUserLanguages() async {
    if (_user != null) {
      List<LanguageModel> languages = _user!.languageList ?? [];
      setState(() {
        _languages = languages;
      });
    }
  }

  void _loadUserCertificate() async {
    if (_user != null) {
      List<CertificateModel> certificate = _user!.certeficatesList ?? [];
      setState(() {
        _certificate = certificate;
      });
    }
  }

  void _loadUserExperience() async {
    if (_user != null) {
      List<ExperienceModel> experience = _user!.experiencesList ?? [];
      setState(() {
        _exp = experience;
      });
    }
  }

  void _loadUserEducation() async {
    if (_user != null) {
      List<EducationModel> education = _user!.schoolsList ?? [];
      setState(() {
        _edc = education;
      });
    }
  }

  void _loadUserSocialMedia() async {
    if (_user != null) {
      List<SocialMediaModel> social = _user!.socialMediaList ?? [];
      setState(() {
        _scl = social;
      });
    }
  }

  void _loadUserSkill() async {
    if (_user != null) {
      List<SkillModel> skill = _user!.skillsList ?? [];
      setState(() {
        _skll = skill;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _user != null
                      ? Column(
                          children: [
                            //İsim Ve Soyisim Kısmı
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                children: [

                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(Assets.imagesMhProfil),
                                      radius: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundImage: AssetImage(
                                                Assets.imageInstagram),
                                          ),
                                        ),
                                        const CircleAvatar(
                                          radius: 18,
                                          backgroundImage:
                                              AssetImage(Assets.imageLinkedin),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                AppRouteNames
                                                    .profileScreenRoute);
                                          },
                                          child: Icon(
                                            Icons.edit_square,
                                            size: 30,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(Icons.share_outlined,
                                              size: 30,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Hakkımda Kısmı
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hakkımda",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      _user!.aboutMe!,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Kişisel Bilgiler
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kişisel Bilgiler",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  Text(
                                    "Doğum Tarihi",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(_user!.userBirthDate!),
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  //-----------------------------------------------------------
                                  Text(
                                    "Adres",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${_user!.city} - ${_user!.district}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ), //-----------------------------------------------------------
                                  Text(
                                    "Telefon Numarası",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      _user!.userPhoneNumber!,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ), //-----------------------------------------------------------
                                  Text(
                                    "E-Posta Adresi",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      _user!.userEmail,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ), //-----------------------------------------------------------
                                  Text(
                                    "Cinsiyet",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      _user!.gender!,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18),
                                    ),
                                  ), //-----------------------------------------------------------
                                  Text(
                                    "Askerlik Durumu",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      _user!.militaryStatus!,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18),
                                    ),
                                  ),
                                  //-----------------------------------------------------------
                                  Text(
                                    "Engellilik Durumu",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      _user!.disabilityStatus!,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //---------------Yetkinliklerim Kısmı-----------------------
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Yetkinliklerim",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Yetkinlikler"),
                                                content: SizedBox(
                                                  width: double.maxFinite,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: _skll!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      SkillModel skill =
                                                          _skll![index];
                                                      return SkillsWidget(
                                                        skill:
                                                            skill.skillName ??
                                                                "",
                                                      );
                                                    },
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Kapat'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.visibility_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  if (_skll == null)
                                    const CircularProgressIndicator()
                                  else if (_skll!.isEmpty)
                                    const Text("Yetenek bilgisi bulunamadı.")
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          _skll!.length > 4 ? 4 : _skll!.length,
                                      itemBuilder: (context, index) {
                                        SkillModel skill = _skll![index];
                                        return SkillsWidget(
                                          skill: skill.skillName ?? "",
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                            //Yabancı Diller Kısmı-------------------------------------------------------------
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yabancı Diller",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  if (_languages == null)
                                    const CircularProgressIndicator()
                                  else if (_languages!.isEmpty)
                                    const Text("Dil bilgisi bulunamadı.")
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _languages!.length,
                                      itemBuilder: (context, index) {
                                        LanguageModel language =
                                            _languages![index];
                                        return LanguageWidget(
                                          language: language.languageName ?? "",
                                          languageLevel:
                                              language.languageLevel ?? "",
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                            //----Sertifika Kısmı-------------------------------------------------------------
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sertifikalarım",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  if (_certificate == null)
                                    const CircularProgressIndicator()
                                  else if (_certificate!.isEmpty)
                                    const Text("Sertifika bilgisi bulunamadı.")
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _certificate!.length,
                                      itemBuilder: (context, index) {
                                        CertificateModel certificateModel =
                                            _certificate![index];
                                        return LanguageWidget(
                                            language: DateFormat('yyyy').format(
                                                certificateModel
                                                    .certificateYear),
                                            languageLevel: certificateModel
                                                .certificateName);
                                      },
                                    ),
                                ],
                              ),
                            ),
                            //Profesyonel iş deneyimi kısmı-------------------------------------------------------
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profesyonel İş Deneyimi",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  if (_exp == null)
                                    const CircularProgressIndicator()
                                  else if (_exp!.isEmpty)
                                    const Text("İş bilgisi bulunamadı.")
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _exp!.length,
                                      itemBuilder: (context, index) {
                                        ExperienceModel experience =
                                            _exp![index];
                                        return DateAndContentWidget(
                                            date: experience.isCurrentlyWorking!
                                                ? "${DateFormat('dd/MM/yyyy').format(experience.startDate)} - Çalışmaya devam ediyor"
                                                : "${DateFormat('dd/MM/yyyy').format(experience.startDate)} - ${DateFormat('dd/MM/yyyy').format(experience.endDate)}",
                                            content:
                                                experience.experiencePosition);
                                      },
                                    ),
                                ],
                              ),
                            ),
                            //Eğitim Hayatımm---------------------------------
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Eğitim Hayatım",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                  if (_edc == null)
                                    const CircularProgressIndicator()
                                  else if (_edc!.isEmpty)
                                    const Text("Okul bilgisi bulunamadı.")
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _edc!.length,
                                      itemBuilder: (context, index) {
                                        EducationModel education = _edc![index];
                                        return DateAndContentWidget(
                                            date: education.isCurrentlyStuding!
                                                ? "${DateFormat('dd/MM/yyyy').format(education.schoolStartDate)} - Okula devam ediyor"
                                                : "${DateFormat('dd/MM/yyyy').format(education.schoolEndDate)} - ${DateFormat('dd/MM/yyyy').format(education.schoolEndDate)}",
                                            content:
                                                "${education.schoolName} - ${education.schoolBranch}");
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child:
                              CircularProgressIndicator(), // Veri yüklenirken gösterilecek görsel
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
