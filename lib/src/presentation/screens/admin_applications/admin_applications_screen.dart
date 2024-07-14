import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/data/export_data.dart';

import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';
import '../export_screens.dart';

class AdminApplicationsScreen extends StatefulWidget {
  const AdminApplicationsScreen({super.key});

  @override
  State<AdminApplicationsScreen> createState() =>
      _AdminApplicationsScreenState();
}

String? _selectedUserTitle;

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

  await UserRepository().updateUser(updatedUser);

  Utilities.showToast(toastMessage: result);
}

void _denyApplication(
  ApplicationModel applicationModel,
  BuildContext context,
) async {
  UserModel? currentUser = await UserRepository().getCurrentUser();

  ApplicationModel updatedApplication = applicationModel.copyWith(
    applicationStatus: ApplicationStatus.denied,
    applicationClosedAt: DateTime.now(),
    applicationClosedBy: currentUser!.userId,
  );

  String result = await ApplicationsRepository()
      .addOrUpdateApplication(applicationModel: updatedApplication);

  Utilities.showToast(toastMessage: result);
  if (!context.mounted) return;
  Navigator.of(context).pop();
}

void _showApplicationDetails(
  ApplicationModel applicationModel,
  String userTitle,
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
              'Başvuru Tarihi: ${DateFormat('dd/MM/yyyy').format(applicationModel.applicationCreatedAt)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'Güncellenme Tarihi: ${DateFormat('dd/MM/yyyy').format(applicationModel.applicationClosedAt)}',
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
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        title: Text(
                          'Kullanıcıya Ünvan Şeçin!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PopupMenuButton<String>(
                              initialValue: _selectedUserTitle,
                              itemBuilder: (context) {
                                return TBTDataCollection.userTitlesList
                                    .map(
                                      (userTitle) => PopupMenuItem<String>(
                                        value: userTitle,
                                        child: Text(
                                          userTitle,
                                        ),
                                      ),
                                    )
                                    .toList();
                              },
                              onSelected: (value) {
                                setState(() {
                                  _selectedUserTitle = value;
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  _selectedUserTitle ?? 'Ünvan Seçiniz!',
                                ),
                                titleTextStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                trailing: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => _approveApplication(
                              applicationModel,
                              _selectedUserTitle ??
                                  TBTDataCollection.userTitlesList[0],
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Kullanıcı Başvuruları",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseService()
                        .firebaseFirestore
                        .collection(FirebaseConstants.applicationsCollection)
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
                                ApplicationModel.fromMap(documentSnapshot.data()
                                    as Map<String, dynamic>);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: GestureDetector(
                                onTap: () {
                                  _showApplicationDetails(
                                    applicationModel,
                                    _selectedUserTitle ??
                                        TBTDataCollection.userTitlesList[0],
                                    context,
                                  );
                                },
                                child: ApplicationCard(
                                  applicationModel: applicationModel,
                                ),
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
    );
  }
}
