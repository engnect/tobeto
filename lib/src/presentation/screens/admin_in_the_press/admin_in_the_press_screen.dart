import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import 'package:uuid/uuid.dart';

import '../../../common/export_common.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

class AdminInThePressScreen extends StatefulWidget {
  const AdminInThePressScreen({
    super.key,
  });

  @override
  State<AdminInThePressScreen> createState() => _AdminInThePressScreenState();
}

class _AdminInThePressScreenState extends State<AdminInThePressScreen> {
  final TextEditingController _blogTitleController = TextEditingController();
  final TextEditingController _blogContentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  XFile? _selectedImage;
  bool _selected = false;

  _selectImageFromGallery({
    required XFile? selectedImage,
    required BuildContext context,
  }) async {
    _selectedImage = await Utilities.getImageFromGallery();
    if (_selectedImage != null && context.mounted) {
      setState(() {
        _selected = true;
      });

      Utilities.showSnackBar(
        snackBarMessage: 'Resim seçmediniz!',
        context: context,
      );
    } else {
      setState(() {
        _selected = false;
      });
    }
  }

  Future<void> addNewInThePressContent({
    required String blogTitle,
    required String blogContent,
    required XFile? selectedImage,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();

    String blogId = const Uuid().v1();
    String blogImageUrl = await FirebaseStorageRepository().putBlogPicToStorage(
      isBlog: false,
      blogId: blogId,
      selectedImage: selectedImage,
    );

    BlogModel blogModel = BlogModel(
      blogId: blogId,
      userId: userModel!.userId,
      userFullName: '${userModel.userName} ${userModel.userSurname}',
      blogCreatedAt: DateTime.now(),
      blogTitle: _blogTitleController.text,
      blogContent: _blogContentController.text,
      blogImageUrl: blogImageUrl,
    );

    String result = await BlogRepository(isBlog: false)
        .addOrUpdateBlog(blogModel: blogModel);

    _selectedImage = null;
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _blogTitleController.dispose();
    _blogContentController.dispose();
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
                        TBTAnimatedContainer(
                          height: 300,
                          infoText: 'Yeni İçerik Ekle!',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                // foto seçimi
                                GestureDetector(
                                  onTap: () => _selectImageFromGallery(
                                    selectedImage: _selectedImage,
                                    context: context,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 50, top: 30),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              150, 150, 150, 0.2),
                                          image: _selected
                                              ? DecorationImage(
                                                  image: FileImage(
                                                    File(_selectedImage!.path),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        child: _selected
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
                                  controller: _blogTitleController,
                                  onSaved: (p0) {},
                                  keyboardType: TextInputType.multiline,
                                ),
                                TBTInputField(
                                  minLines: 5,
                                  hintText: "İçerik",
                                  controller: _blogContentController,
                                  onSaved: (p0) {},
                                  keyboardType: TextInputType.multiline,
                                ),

                                // buton
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: TBTPurpleButton(
                                    buttonText: "Kaydet",
                                    onPressed: () => addNewInThePressContent(
                                      blogTitle: _blogTitleController.text,
                                      blogContent: _blogContentController.text,
                                      selectedImage: _selectedImage,
                                      context: context,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  FirebaseConstants.inThePressCollection)
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
