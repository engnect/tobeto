import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/models/certificate_model.dart';
import 'package:tobeto/src/models/education_model.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/language_model.dart';
import 'package:tobeto/src/presentation/widgets/tbt_end_drawer.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/profile_details_date_and_content_widget.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/profile_details_language_widget.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/personel_info_container_widget.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/profile_detail_widget.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/section_container_widget.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/skills_container_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';

class ProfileDetailsTabScreen extends StatefulWidget {
  const ProfileDetailsTabScreen({super.key});

  @override
  State<ProfileDetailsTabScreen> createState() =>
      _ProfileDetailsTabScreenState();
}

class _ProfileDetailsTabScreenState extends State<ProfileDetailsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const TBTDrawer(),
      endDrawer: const TBTEndDrawer(),
      body: CustomScrollView(
        slivers: [
          const TBTSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Column(
                        children: [
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
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (state.userModel.github !=
                                                          null &&
                                                      state.userModel.github!
                                                          .isNotEmpty)
                                                    Text(
                                                      state.userModel.github!,
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            11, 87, 208, 1),
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  else
                                                    const Text(
                                                      "Github adresi bulunamadı.",
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
                                      ...state.userModel.socialMediaList!
                                          .map((socialMedia) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundImage: AssetImage(
                                                socialMedia
                                                    .socialMediaAssetUrl),
                                          ),
                                        );
                                      }),
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
                          ProfileDetailCard(
                            title: "Hakkımda",
                            content: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                state.userModel.aboutMe ??
                                    'Hakkımda bilgisi bulunamadı!',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          PersonalInfoContainer(
                            birthDate: DateFormat('dd/MM/yyyy')
                                .format(state.userModel.userBirthDate!),
                            city: state.userModel.city ?? '',
                            district: state.userModel.district ?? '',
                            phoneNumber:
                                state.userModel.userPhoneNumber ?? 'Bilgi yok!',
                            email: state.userModel.userEmail,
                            gender: state.userModel.gender ?? 'Bilgi yok!',
                            militaryStatus:
                                state.userModel.militaryStatus ?? 'Bilgi yok!',
                            disabilityStatus:
                                state.userModel.disabilityStatus ??
                                    'Bilgi yok!',
                          ),
                          SkillsContainer(
                            skillsList: state.userModel.skillsList ?? [],
                          ),
                          SectionContainer(
                            title: "Yabancı Diller",
                            itemList: state.userModel.languageList,
                            emptyWidget: const Text("Dil bilgisi bulunamadı."),
                            itemBuilder: (context, index) {
                              LanguageModel language =
                                  state.userModel.languageList![index];
                              return LanguageWidget(
                                language: language.languageName ?? "",
                                languageLevel: language.languageLevel ?? "",
                              );
                            },
                          ),
                          SectionContainer(
                            title: "Sertifikalarım",
                            itemList: state.userModel.certeficatesList,
                            emptyWidget:
                                const Text("Sertifika bilgisi bulunamadı."),
                            itemBuilder: (context, index) {
                              CertificateModel certificate =
                                  state.userModel.certeficatesList![index];
                              return DateAndContentWidget(
                                date: DateFormat('yyyy')
                                    .format(certificate.certificateYear),
                                content: certificate.certificateName,
                              );
                            },
                          ),
                          SectionContainer(
                            title: "Profesyonel İş Deneyimi",
                            itemList: state.userModel.experiencesList,
                            emptyWidget:
                                const Text("Deneyim bilgisi bulunamadı."),
                            itemBuilder: (context, index) {
                              ExperienceModel experience =
                                  state.userModel.experiencesList![index];
                              return DateAndContentWidget(
                                date: experience.isCurrentlyWorking!
                                    ? "${DateFormat('dd/MM/yyyy').format(experience.startDate)} - Çalışmaya devam ediyor"
                                    : "${DateFormat('dd/MM/yyyy').format(experience.startDate)} - ${DateFormat('dd/MM/yyyy').format(experience.endDate)}",
                                content: experience.experiencePosition,
                              );
                            },
                          ),
                          SectionContainer(
                            title: "Eğitim Hayatım",
                            itemList: state.userModel.schoolsList,
                            emptyWidget:
                                const Text("Eğitim hayatı bulunamadı."),
                            itemBuilder: (context, index) {
                              EducationModel education =
                                  state.userModel.schoolsList![index];
                              return DateAndContentWidget(
                                date: education.isCurrentlyStuding!
                                    ? "${DateFormat('dd/MM/yyyy').format(education.schoolStartDate)} - Okula devam ediyor"
                                    : "${DateFormat('dd/MM/yyyy').format(education.schoolStartDate)} - ${DateFormat('dd/MM/yyyy').format(education.schoolEndDate)}",
                                content:
                                    "${education.schoolName} - ${education.schoolBranch}",
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
