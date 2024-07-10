import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
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

      Utilities.showToast(toastMessage: 'Resim Seçmediniz!');
    } else {
      setState(() {
        _selected = false;
      });
    }
  }

  void _addNewInThePressContent({
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
    Utilities.showToast(toastMessage: result);
  }

  void _showEditInThePressDialog(BlogModel blogModel) {
    TextEditingController editTitleController =
        TextEditingController(text: blogModel.blogTitle);
    TextEditingController editContentController =
        TextEditingController(text: blogModel.blogContent);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Basında Biz Yazısını Güncelle'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TBTInputField(
                hintText: 'Başlık',
                controller: editTitleController,
                onSaved: (p0) {},
                keyboardType: TextInputType.multiline,
              ),
              TBTInputField(
                hintText: 'İçerik',
                controller: editContentController,
                onSaved: (p0) {},
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              BlogModel updatedBlog = blogModel.copyWith(
                blogTitle: editTitleController.text,
                blogContent: editContentController.text,
              );

              String result = await BlogRepository(isBlog: false)
                  .addOrUpdateBlog(blogModel: updatedBlog);
              Utilities.showToast(toastMessage: result);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: const Text('Güncelle!'),
          ),
        ],
      ),
    );
  }

  void _showDeleteInThePressDialog({
    required BlogModel blogModel,
    required BuildContext context,
  }) async {
    PanaraConfirmDialog.showAnimatedFade(
      context,
      title: 'Dikkat!',
      message: 'İçeriği KALICI olarak silmek istediğinize eminmisiniz?',
      confirmButtonText: 'Sil!',
      cancelButtonText: 'İptal!',
      onTapConfirm: () async {
        String result = await BlogRepository(isBlog: false)
            .deleteBlog(blogModel: blogModel);

        Utilities.showToast(toastMessage: result);
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
      onTapCancel: () {
        Navigator.of(context).pop();
      },
      panaraDialogType: PanaraDialogType.error,
    );
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TBTAnimatedContainer(
                      height: 400,
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
                                padding:
                                    const EdgeInsets.only(bottom: 50, top: 30),
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TBTPurpleButton(
                                buttonText: "Kaydet",
                                onPressed: () => _addNewInThePressContent(
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
                              deleteOnPressed: (ctx) {
                                _showDeleteInThePressDialog(
                                    blogModel: blogModel, context: context);
                              },
                              editOnPressed: (p0) {
                                _showEditInThePressDialog(blogModel);
                              },
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
