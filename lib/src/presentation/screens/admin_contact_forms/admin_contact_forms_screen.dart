import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

class AdminContactFormsScreen extends StatefulWidget {
  const AdminContactFormsScreen({super.key});

  @override
  State<AdminContactFormsScreen> createState() =>
      _AdminContactFormsScreenState();
}

void _markAsRead({
  required ContactFormModel contactFormModel,
  required BuildContext context,
}) async {
  UserModel? currentUser = await UserRepository().getCurrentUser();
  ContactFormModel updatedContactFormModel = contactFormModel.copyWith(
    contactFormClosedAt: DateTime.now(),
    contactFormIsClosed: true,
    contactFormClosedBy: currentUser!.userId,
  );

  await ContactFromRepository().sendOrUpdateForm(updatedContactFormModel);
  if (!context.mounted) return;
  Navigator.of(context).pop();
}

void _markAsUnread({
  required ContactFormModel contactFormModel,
  required BuildContext context,
}) async {
  UserModel? currentUser = await UserRepository().getCurrentUser();
  ContactFormModel updatedContactFormModel = contactFormModel.copyWith(
    contactFormClosedAt: DateTime.now(),
    contactFormIsClosed: false,
    contactFormClosedBy: currentUser!.userId,
  );

  await ContactFromRepository().sendOrUpdateForm(updatedContactFormModel);

  if (!context.mounted) return;
  Navigator.of(context).pop();
}

void _showFormDetails({
  required ContactFormModel contactFormModel,
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(contactFormModel.contactFormFullName),
        content: Text(contactFormModel.contactFormMessage),
        actions: [
          TextButton(
            onPressed: () => _markAsRead(
              contactFormModel: contactFormModel,
              context: context,
            ),
            child: const Text('Okundu Olarak İşaretle'),
          ),
          TextButton(
            onPressed: () => _markAsUnread(
              contactFormModel: contactFormModel,
              context: context,
            ),
            child: const Text('Okunmadı Olarak İşaretle'),
          ),
        ],
      );
    },
  );
}

class _AdminContactFormsScreenState extends State<AdminContactFormsScreen> {
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
                      "İletişim Formları",
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
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseConstants.contactFormsCollection)
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

                            ContactFormModel contactFormModel =
                                ContactFormModel.fromMap(documentSnapshot.data()
                                    as Map<String, dynamic>);
                            return Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.20,
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {},
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Sil',
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    contactFormModel.contactFormIsClosed ==
                                            false
                                        ? Icons.mark_email_unread_outlined
                                        : Icons.mark_email_read_outlined,
                                    color:
                                        contactFormModel.contactFormIsClosed ==
                                                false
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        contactFormModel.contactFormFullName,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            contactFormModel
                                                .contactFormCreatedAt),
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    contactFormModel.contactFormEmail,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  onTap: () => _showFormDetails(
                                    contactFormModel: contactFormModel,
                                    context: context,
                                  ),
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
