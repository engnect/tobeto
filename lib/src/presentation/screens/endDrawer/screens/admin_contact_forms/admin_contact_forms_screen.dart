import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/models/contact_form_model.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';

class AdminContactFormsScreen extends StatefulWidget {
  const AdminContactFormsScreen({super.key});

  @override
  State<AdminContactFormsScreen> createState() =>
      _AdminContactFormsScreenState();
}

class _AdminContactFormsScreenState extends State<AdminContactFormsScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TBTAppBar(controller: _controller),
        body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "İletişim Formları",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 200,
                child: StreamBuilder(
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
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(contactFormModel.contactFormFullName),
                                Text(DateFormat('dd/MM/yyyy').format(
                                    contactFormModel.contactFormCreatedAt)),
                              ],
                            ),
                            subtitle: Text(contactFormModel.contactFormEmail),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        contactFormModel.contactFormFullName),
                                    content: Text(
                                        contactFormModel.contactFormMessage),
                                    actions: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('Okundu Olarak İşaretle'),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('Okundu Olarak İşaretle'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
