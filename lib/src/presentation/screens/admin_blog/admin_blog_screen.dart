import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

class AdminBlogScreen extends StatefulWidget {
  const AdminBlogScreen({
    super.key,
  });

  @override
  State<AdminBlogScreen> createState() => _AdminBlogScreenState();
}

class _AdminBlogScreenState extends State<AdminBlogScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  XFile? selectedImage;
  bool selected = false;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        selectedImage = file;
        if (selectedImage != null) {
          selected = true;
        }
      });
    }
  }

  _addNewBlog({
    required XFile? selectedImage,
    required String blogTitle,
    required String blogContent,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String blogId = const Uuid().v1();
    String blogImageUrl = await FirebaseStorageRepository().putBlogPicToStorage(
      isBlog: true,
      blogId: blogId,
      selectedImage: selectedImage,
    );
    BlogModel blogModel = BlogModel(
      blogId: blogId,
      userId: userModel!.userId,
      userFullName: '${userModel.userName} ${userModel.userSurname}',
      blogCreatedAt: DateTime.now(),
      blogTitle: blogTitle,
      blogContent: blogContent,
      blogImageUrl: blogImageUrl,
    );

    String result = await BlogRepository(isBlog: true)
        .addOrUpdateBlog(blogModel: blogModel);
    Utilities.showToast(toastMessage: result);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
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
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Blogları Düzenle",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TBTAnimatedContainer(
                        height: 300,
                        infoText: 'Yeni Blog Yazısı Ekle!',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              // foto seçimi
                              GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, top: 30),
                                  child: Container(
                                    width: 250,
                                    height: 250,
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
                              // inputlar
                              TBTInputField(
                                hintText: "Başlık",
                                controller: _titleController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline,
                              ),
                              TBTInputField(
                                minLines: 5,
                                hintText: "İçerik",
                                controller: _contentController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline,
                              ),

                              // buton
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: TBTPurpleButton(
                                  buttonText: "Kaydet",
                                  onPressed: () => _addNewBlog(
                                    selectedImage: selectedImage,
                                    blogTitle: _titleController.text,
                                    blogContent: _contentController.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.blogsCollection)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              controller: _scrollController,
                              primary: false,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
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
              ],
            ),
          ),
        ],
      )),
    );
  }
}
