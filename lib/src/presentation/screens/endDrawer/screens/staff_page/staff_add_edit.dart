import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class StaffAddEdit extends StatefulWidget {
  const StaffAddEdit({super.key});

  @override
  State<StaffAddEdit> createState() => _StaffAddEditState();
}

class _StaffAddEditState extends State<StaffAddEdit> {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? selectedImage;
  bool selected = false;

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
                        child: CircleAvatar(
                          backgroundImage: selected
                              ? FileImage(File(selectedImage!.path))
                              : null,
                          radius: 50,
                          child: selected
                              ? null
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                ),
                        ),
                      ),
                    ),
                    TBTInputField(
                        hintText: "Personel İsmi",
                        controller: nameController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline),
                    TBTInputField(
                        hintText: "Görev",
                        controller: jobController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TBTPurpleButton(
                        buttonText: "Kaydet",
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
