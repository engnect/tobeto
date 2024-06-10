import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/domain/repositories/blog_repository.dart';
import 'package:tobeto/src/models/blog_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class InThePressAddEdit extends StatefulWidget {
  const InThePressAddEdit({super.key});

  @override
  State<InThePressAddEdit> createState() => _InThePressAddEditState();
}

class _InThePressAddEditState extends State<InThePressAddEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? selectedImage;
  bool selected = false;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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

  void getCurrentUser() async {
    userModel = await AuthRepository().getCurrentUser();
  }

  //kamera mı ? galeri mi ? ekle!!!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ekle & Düzenle"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        blurRadius: 20,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50, top: 30),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(150, 150, 150, 0.2),
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
                    TBTInputField(
                        hintText: "Başlık",
                        controller: titleController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline),
                    TBTInputField(
                        minLines: 5,
                        hintText: "İçerik",
                        controller: contentController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TBTPurpleButton(
                        buttonText: "Kaydet",
                        onPressed: () async {
                          BlogModel blogModel = BlogModel(
                            blogId: '1',
                            userId: userModel.userId,
                            userFullName:
                                '${userModel.userName} ${userModel.userSurname}',
                            blogCreatedAt: DateTime.now(),
                            blogTitle: titleController.text,
                            blogContent: contentController.text,
                            blogImageUrl:
                                'https://images.unsplash.com/photo-1718011087751-e82f1792aa32?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5fHx8ZW58MHx8fHx8',
                          );

                          await BlogRepository().addBlog(blogModel: blogModel);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
