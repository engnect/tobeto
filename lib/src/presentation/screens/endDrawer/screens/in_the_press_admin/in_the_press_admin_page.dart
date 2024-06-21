import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/domain/repositories/blog_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/blog_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_admin_sliver_app_bar.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:uuid/uuid.dart';

import '../../../../widgets/tbt_slideable_list_tile.dart';

class InThePressAdmin extends StatefulWidget {
  const InThePressAdmin({
    super.key,
  });

  @override
  State<InThePressAdmin> createState() => _InThePressAdminState();
}

class _InThePressAdminState extends State<InThePressAdmin> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  XFile? selectedImage;
  bool selected = false;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file != null) {
      setState(() {
        selectedImage = file;
        if (selectedImage != null) {
          selected = true;
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          const TBTAdminSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "İçeriği Düzenle",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  TBTAnimatedContainer(
                    height: 300,
                    infoText: 'Yeni İçerik Ekle!',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // foto seçimi
                          GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 50, top: 30),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        150, 150, 150, 0.2),
                                    image: selected
                                        ? DecorationImage(
                                            image: FileImage(
                                              File(selectedImage!.path),
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: selected
                                      ? null
                                      : const Icon(
                                          Icons.camera_alt,
                                          size: 50,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          // inputlar
                          TBTInputField(
                            hintText: "Başlık",
                            controller: titleController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.multiline,
                          ),
                          TBTInputField(
                            minLines: 5,
                            hintText: "İçerik",
                            controller: contentController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.multiline,
                          ),

                          // buton
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TBTPurpleButton(
                              buttonText: "Kaydet",
                              onPressed: () async {
                                UserModel? userModel =
                                    await UserRepository().getCurrentUser();

                                BlogModel blogModel = BlogModel(
                                  blogId: const Uuid().v1(),
                                  userId: userModel!.userId,
                                  userFullName:
                                      '${userModel.userName} ${userModel.userSurname}',
                                  blogCreatedAt: DateTime.now(),
                                  blogTitle: titleController.text,
                                  blogContent: contentController.text,
                                  blogImageUrl:
                                      'https://images.unsplash.com/photo-1718011087751-e82f1792aa32?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5fHx8ZW58MHx8fHx8',
                                );

                                await BlogRepository(isBlog: false)
                                    .addOrUpdateBlog(blogModel: blogModel);

                                selectedImage = null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseConstants.inThePressCollection)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          primary: false,
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];

                            BlogModel blogModel = BlogModel.fromMap(
                                documentSnapshot.data()
                                    as Map<String, dynamic>);

                            return TBTSlideableListTile(
                              imgUrl: blogModel.blogImageUrl,
                              title: blogModel.blogTitle,
                              subtitle: blogModel.blogContent,
                              deleteOnPressed: (p0) {},
                              editOnPressed: (p0) {},
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ]))
        ],
      )),
    );
  }
}
