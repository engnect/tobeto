import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/enums/application_status_enum.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/applications_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/application_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/application_card.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/tbt_admin_sliver_app_bar.dart';

class AdminApplicationsScreen extends StatefulWidget {
  const AdminApplicationsScreen({super.key});

  @override
  State<AdminApplicationsScreen> createState() =>
      _AdminApplicationsScreenState();
}

void _approveApplication(
  ApplicationModel applicationModel,
  String userTitle,
  BuildContext context,
) async {
  UserModel? currentUser = await UserRepository().getCurrentUser();

  UserModel? applicationOwner =
      await UserRepository().getSpecificUserById(applicationModel.userId);

  UserModel updatedUser = applicationOwner!.copyWith(
    userRank: applicationModel.userRank,
    usertitle: userTitle,
  );

  ApplicationModel updatedApplication = applicationModel.copyWith(
    applicationStatus: ApplicationStatus.approved,
    applicationClosedAt: DateTime.now(),
    applicationClosedBy: currentUser!.userId,
  );

  String result = await ApplicationsRepository()
      .addOrUpdateApplication(applicationModel: updatedApplication);

  await UserRepository().addOrUpdateUser(updatedUser);

  if (!context.mounted) return;
  Utilities.showSnackBar(snackBarMessage: result, context: context);
}

void _denyApplication(
    ApplicationModel applicationModel, BuildContext context) async {
  UserModel? currentUser = await UserRepository().getCurrentUser();

  ApplicationModel updatedApplication = applicationModel.copyWith(
    applicationStatus: ApplicationStatus.denied,
    applicationClosedAt: DateTime.now(),
    applicationClosedBy: currentUser!.userId,
  );

  String result = await ApplicationsRepository()
      .addOrUpdateApplication(applicationModel: updatedApplication);

  if (!context.mounted) return;
  Utilities.showSnackBar(snackBarMessage: result, context: context);
  Navigator.of(context).pop();
}

void _showApplicationDetails(
  ApplicationModel applicationModel,
  TextEditingController userTitleController,
  BuildContext context,
) async {
  UserModel? userModel =
      await UserRepository().getSpecificUserById(applicationModel.userId);

  UserModel? applicationClosedBy = await UserRepository().getCurrentUser();

  if (!context.mounted) return;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          '${userModel!.userName} ${userModel.userSurname}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              applicationModel.applicationContent,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'B.T.: ${DateFormat('dd/MM/yyyy').format(applicationModel.applicationCreatedAt)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'G.T.: ${DateFormat('dd/MM/yyyy').format(applicationModel.applicationClosedAt)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'Başvuruyu Cevaplayan: ${applicationClosedBy!.userName} ${applicationClosedBy.userSurname}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    title: Text(
                      'Kullanıcıya Ünvan Yazın!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TBTInputField(
                          hintText: 'Ünvan',
                          controller: userTitleController,
                          onSaved: (p0) {},
                          keyboardType: TextInputType.multiline,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => _approveApplication(
                          applicationModel,
                          userTitleController.text,
                          context,
                        ),
                        child: const Text(
                          'Onayla',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () => _denyApplication(applicationModel, context),
            icon: const Icon(Icons.close),
          ),
        ],
      );
    },
  );
}

class _AdminApplicationsScreenState extends State<AdminApplicationsScreen> {
  final TextEditingController _userTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const TBTAdminSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Kullanıcı Başvuruları",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  FirebaseConstants.applicationsCollection)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];

                                  ApplicationModel applicationModel =
                                      ApplicationModel.fromMap(documentSnapshot
                                          .data() as Map<String, dynamic>);

                                  return GestureDetector(
                                    onTap: () {
                                      _showApplicationDetails(
                                        applicationModel,
                                        _userTitleController,
                                        context,
                                      );
                                    },
                                    child: ApplicationCard(
                                      applicationModel: applicationModel,
                                    ),
                                  );
                                },
                              );
                            }
                          },
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
