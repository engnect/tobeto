import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/enums/application_status_enum.dart';
import 'package:tobeto/src/common/enums/application_type_enum.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/domain/repositories/applications_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/application_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/end_drawer.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/application_card.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import 'package:uuid/uuid.dart';

class ApplicationsTab extends StatefulWidget {
  const ApplicationsTab({super.key});

  @override
  State<ApplicationsTab> createState() => _ApplicationsTabState();
}

class _ApplicationsTabState extends State<ApplicationsTab> {
  final TextEditingController _applicationContentController =
      TextEditingController();
  ApplicationType _selectedApplication = ApplicationType.admin;
  UserRank _selectedUserRank = UserRank.admin;

  @override
  void dispose() {
    super.dispose();
    _applicationContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      children: [
                        TBTAnimatedContainer(
                          height: 450,
                          infoText: 'Yeni Başvuru Yap!',
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Text(
                                      "Başvuru Türünü Seçiniz",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Poppins",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                  RadioListTile<ApplicationType>(
                                    toggleable: true,
                                    title: Text(
                                      'Admin',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    value: ApplicationType.admin,
                                    groupValue: _selectedApplication,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedApplication = value!;
                                        _selectedUserRank = UserRank.admin;
                                      });
                                    },
                                  ),
                                  RadioListTile<ApplicationType>(
                                    toggleable: true,
                                    title: Text(
                                      'Eğitmen',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    value: ApplicationType.instructor,
                                    groupValue: _selectedApplication,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedApplication = value!;
                                        _selectedUserRank = UserRank.instructor;
                                      });
                                    },
                                  ),
                                  RadioListTile<ApplicationType>(
                                    toggleable: true,
                                    title: Text(
                                      'İstanbul Kodluyor',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    value: ApplicationType.istanbulkodluyor,
                                    groupValue: _selectedApplication,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedApplication = value!;
                                        _selectedUserRank = UserRank.student;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TBTInputField(
                                      minLines: 3,
                                      hintText: 'Başvuru Açıklaması Giriniz',
                                      controller: _applicationContentController,
                                      onSaved: (p0) {},
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TBTPurpleButton(
                                      buttonText: "Başvur",
                                      onPressed: () async {
                                        UserModel? userModel =
                                            await UserRepository()
                                                .getCurrentUser();
                                        ApplicationModel applicationModel =
                                            ApplicationModel(
                                          applicationId: const Uuid().v1(),
                                          userId: userModel!.userId,
                                          applicationContent:
                                              _applicationContentController
                                                  .text,
                                          applicationType: _selectedApplication,
                                          userRank: _selectedUserRank,
                                          applicationStatus:
                                              ApplicationStatus.waiting,
                                          applicationCreatedAt: DateTime.now(),
                                          applicationClosedBy:
                                              'applicationClosedBy',
                                          applicationClosedAt: DateTime.now(),
                                        );

                                        String result =
                                            await ApplicationsRepository()
                                                .addOrUpdateApplication(
                                                    applicationModel:
                                                        applicationModel);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // stream

                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is Authenticated) {
                              UserModel currentUser = state.userModel;
                              return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(FirebaseConstants
                                        .applicationsCollection)
                                    .where('userId',
                                        isEqualTo: currentUser.userId)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot documentSnapshot =
                                            snapshot.data!.docs[index];

                                        ApplicationModel applicationModel =
                                            ApplicationModel.fromMap(
                                                documentSnapshot.data()
                                                    as Map<String, dynamic>);

                                        return ApplicationCard(
                                            applicationModel: applicationModel);
                                      },
                                    );
                                  }
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),

                        const SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
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
