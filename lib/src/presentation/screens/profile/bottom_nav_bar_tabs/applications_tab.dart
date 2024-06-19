import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/enums/application_type_enum.dart';
import 'package:tobeto/src/domain/repositories/applications_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/application_model.dart';
import 'package:tobeto/src/models/user_model.dart';
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

  @override
  void dispose() {
    super.dispose();
    _applicationContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20, top: 10),
                                    child: Text(
                                      "Başvuru Türünü Seçiniz",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                  ),
                                  RadioListTile<ApplicationType>(
                                    toggleable: true,
                                    title: const Text('Admin'),
                                    value: ApplicationType.admin,
                                    groupValue: _selectedApplication,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedApplication = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile<ApplicationType>(
                                    toggleable: true,
                                    title: const Text('Eğitmen'),
                                    value: ApplicationType.instructor,
                                    groupValue: _selectedApplication,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedApplication = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile<ApplicationType>(
                                    toggleable: true,
                                    title: const Text('İstanbul Kodluyor'),
                                    value: ApplicationType.istanbulkodluyor,
                                    groupValue: _selectedApplication,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedApplication = value!;
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
                                          didApplicationApproved: false,
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

                                        print(result);
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
