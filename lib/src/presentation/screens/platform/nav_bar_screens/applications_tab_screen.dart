import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:uuid/uuid.dart';
import '../../../../common/export_common.dart';
import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class ApplicationsTabScreen extends StatefulWidget {
  const ApplicationsTabScreen({super.key});

  @override
  State<ApplicationsTabScreen> createState() => _ApplicationsTabScreenState();
}

class _ApplicationsTabScreenState extends State<ApplicationsTabScreen> {
  final TextEditingController _applicationContentController =
      TextEditingController();
  ApplicationType _selectedApplication = ApplicationType.admin;
  UserRank _selectedUserRank = UserRank.admin;

  _makeNewApplication({
    required String applicationContent,
    required ApplicationType applicationType,
    required UserRank userRank,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    ApplicationModel applicationModel = ApplicationModel(
      applicationId: const Uuid().v1(),
      userId: userModel!.userId,
      applicationContent: applicationContent,
      applicationType: applicationType,
      userRank: userRank,
      applicationStatus: ApplicationStatus.waiting,
      applicationCreatedAt: DateTime.now(),
      applicationClosedBy: 'applicationClosedBy',
      applicationClosedAt: DateTime.now(),
    );

    String result = await ApplicationsRepository()
        .addOrUpdateApplication(applicationModel: applicationModel);
    Utilities.showToast(toastMessage: result);
  }

  @override
  void dispose() {
    super.dispose();
    _applicationContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const TBTEndDrawer(),
      drawer: const TBTDrawer(),
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
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                    onPressed: () => _makeNewApplication(
                                      applicationContent:
                                          _applicationContentController.text,
                                      applicationType: _selectedApplication,
                                      userRank: _selectedUserRank,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is Authenticated) {
                            UserModel currentUser = state.userModel;
                            return StreamBuilder(
                              stream: FirebaseService()
                                  .firebaseFirestore
                                  .collection(
                                      FirebaseConstants.applicationsCollection)
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
    );
  }
}
