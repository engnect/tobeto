import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/domain/repositories/contact_form_repository.dart';
import 'package:tobeto/src/models/contact_form_model.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';

class AdminContactFormsScreen extends StatefulWidget {
  const AdminContactFormsScreen({super.key});

  @override
  State<AdminContactFormsScreen> createState() =>
      _AdminContactFormsScreenState();
}

class _AdminContactFormsScreenState extends State<AdminContactFormsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "İletişim Formları",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            200,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  FirebaseConstants.contactFormsCollection)
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
                                      ContactFormModel.fromMap(documentSnapshot
                                          .data() as Map<String, dynamic>);
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: 0.20,
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {},
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Sil',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      color: contactFormModel
                                                  .contactFormIsClosed ==
                                              false
                                          ? const Color.fromRGBO(
                                              200, 255, 0, 0.13)
                                          : const Color.fromRGBO(
                                              60, 255, 0, 0.188),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: ListTile(
                                          leading: Icon(
                                            contactFormModel
                                                        .contactFormIsClosed ==
                                                    false
                                                ? Icons
                                                    .mark_email_unread_outlined
                                                : Icons
                                                    .mark_email_read_outlined,
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(contactFormModel
                                                  .contactFormFullName),
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    contactFormModel
                                                        .contactFormCreatedAt),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(contactFormModel
                                              .contactFormEmail),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(contactFormModel
                                                      .contactFormFullName),
                                                  content: Text(contactFormModel
                                                      .contactFormMessage),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        ContactFormModel
                                                            updatedContactFormModel =
                                                            contactFormModel
                                                                .copyWith(
                                                          contactFormClosedAt:
                                                              DateTime.now(),
                                                          contactFormIsClosed:
                                                              true,
                                                          contactFormClosedBy:
                                                              'alperen',
                                                        );

                                                        await ContactFromRepository()
                                                            .sendOrUpdateForm(
                                                                updatedContactFormModel);
                                                        if (!context.mounted)
                                                          return;
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                          'Okundu Olarak İşaretle'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        ContactFormModel
                                                            updatedContactFormModel =
                                                            contactFormModel
                                                                .copyWith(
                                                          contactFormClosedAt:
                                                              DateTime.now(),
                                                          contactFormIsClosed:
                                                              false,
                                                          contactFormClosedBy:
                                                              'muhammed',
                                                        );

                                                        await ContactFromRepository()
                                                            .sendOrUpdateForm(
                                                                updatedContactFormModel);

                                                        if (!context.mounted)
                                                          return;

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                          'Okunmadı Olarak İşaretle'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
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
