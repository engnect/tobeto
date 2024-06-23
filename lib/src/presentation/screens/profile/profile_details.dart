import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/models/certificate_model.dart';
import 'package:tobeto/src/models/education_model.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/language_model.dart';
import 'package:tobeto/src/models/skill_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is Authenticated) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      state.userModel.userAvatarUrl!,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ad Soyad",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Text(
                                            "${state.userModel.userName} ${state.userModel.userSurname}",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (state
                                                    .userModel
                                                    .socialMediaList!
                                                    .isNotEmpty)
                                                  Column(
                                                    children: state.userModel
                                                        .socialMediaList!
                                                        .map((socialMedia) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 4),
                                                        child: Text(
                                                          socialMedia
                                                              .socialMedialink,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    11,
                                                                    87,
                                                                    208,
                                                                    1),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  )
                                                else
                                                  const Text(
                                                    "Sosyal medya bilgisi bulunamadı.",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundImage: AssetImage(
                                          Assets.imageInstagram,
                                        ),
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                        Assets.imageLinkedin,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          AppRouteNames.profileScreenRoute,
                                        );
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
                                      child: Icon(
                                        Icons.share_outlined,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hakkımda",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  state.userModel.aboutMe ??
                                      'Hakkımda bilgisi bulunamadı!',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              Text(
                                "Doğum Tarihi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(state.userModel.userBirthDate!),
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                "Adres",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "${state.userModel.city ?? ''} - ${state.userModel.district ?? ''}",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                "Telefon Numarası",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  state.userModel.userPhoneNumber ??
                                      'Bilgi yok!',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              Text(
                                "E-Posta Adresi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  state.userModel.userEmail,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                "Cinsiyet",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  state.userModel.gender ?? 'Bilgi yok!',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18),
                                ),
                              ),
                              Text(
                                "Askerlik Durumu",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  state.userModel.militaryStatus ??
                                      'Bilgi yok!',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18),
                                ),
                              ),
                              Text(
                                "Engellilik Durumu",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  state.userModel.disabilityStatus ??
                                      'Bilgi yok!',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const Spacer(),
                                  state.userModel.skillsList == []
                                      ? const SizedBox.shrink()
                                      : IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Yetkinlikler"),
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: state.userModel
                                                          .skillsList!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        SkillModel skill = state
                                                            .userModel
                                                            .skillsList![index];
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
                                                      child:
                                                          const Text('Kapat'),
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              if (state.userModel.skillsList == [])
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (state.userModel.skillsList!.isEmpty)
                                Text(
                                  'Yetkinlik bilgisi bulunamadı.',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.userModel.skillsList!.length > 4
                                          ? 4
                                          : state.userModel.skillsList!.length,
                                  itemBuilder: (context, index) {
                                    SkillModel skill =
                                        state.userModel.skillsList![index];
                                    return SkillsWidget(
                                      skill: skill.skillName ?? "",
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Yabancı Diller",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              if (state.userModel.languageList == null)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (state.userModel.languageList!.isEmpty)
                                Text(
                                  "Dil bilgisi bulunamadı.",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.userModel.languageList!.length,
                                  itemBuilder: (context, index) {
                                    LanguageModel language =
                                        state.userModel.languageList![index];
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sertifikalarım",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              if (state.userModel.certeficatesList == null)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (state
                                  .userModel.certeficatesList!.isEmpty)
                                Text(
                                  "Sertifika bilgisi bulunamadı.",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.userModel.certeficatesList!.length,
                                  itemBuilder: (context, index) {
                                    CertificateModel certificateModel = state
                                        .userModel.certeficatesList![index];
                                    return LanguageWidget(
                                        language: DateFormat('yyyy').format(
                                            certificateModel.certificateYear),
                                        languageLevel:
                                            certificateModel.certificateName);
                                  },
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profesyonel İş Deneyimi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              if (state.userModel.experiencesList == [])
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (state.userModel.experiencesList!.isEmpty)
                                Text(
                                  "Deneyim bilgisi bulunamadı.",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.userModel.experiencesList!.length,
                                  itemBuilder: (context, index) {
                                    ExperienceModel experience =
                                        state.userModel.experiencesList![index];
                                    return DateAndContentWidget(
                                        date: experience.isCurrentlyWorking!
                                            ? "${DateFormat('dd/MM/yyyy').format(experience.startDate)} - Çalışmaya devam ediyor"
                                            : "${DateFormat('dd/MM/yyyy').format(experience.startDate)} - ${DateFormat('dd/MM/yyyy').format(experience.endDate)}",
                                        content: experience.experiencePosition);
                                  },
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Eğitim Hayatım",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              if (state.userModel.schoolsList == [])
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (state.userModel.schoolsList!.isEmpty)
                                Text(
                                  "Eğitim hayatı bulunamadı.",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.userModel.schoolsList!.length,
                                  itemBuilder: (context, index) {
                                    EducationModel education =
                                        state.userModel.schoolsList![index];
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
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
