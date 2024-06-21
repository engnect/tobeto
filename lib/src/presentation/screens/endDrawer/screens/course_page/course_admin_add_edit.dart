import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:uuid/uuid.dart';

class CourseAddEdit extends StatefulWidget {
  const CourseAddEdit({super.key});

  @override
  State<CourseAddEdit> createState() => _CourseAddEditState();
}

class _CourseAddEditState extends State<CourseAddEdit> {
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

  XFile? selectedImage;
  bool selected = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadCourseNames();
  }

  void _loadCourseNames() {
    _courseRepository.fetchAllCourses().listen((courseList) {
      setState(() {
        courses = courseList;
        courseNames = courseList.map((course) => course.courseName).toList();
      });
    });
  }

  void _saveCourse() async {
    if (selectedImage != null &&
        _courseNameController.text.isNotEmpty &&
        // _courseStartDateController.text.isNotEmpty &&
        // _courseEndDateController.text.isNotEmpty &&
        _courseManufacturerController.text.isNotEmpty) {
      String? thumbnailUrl = await FirebaseStorageRepository()
          .uploadCourseThumbnailsAndSaveUrl(
              selectedCourseThumbnail: selectedImage);
      if (thumbnailUrl != null) {
        CourseModel courseModel = CourseModel(
            courseId: const Uuid().v1(),
            courseThumbnailUrl: thumbnailUrl,
            courseName: _courseNameController.text,
            courseStartDate: DateTime.now(),
            courseEndDate: DateTime.now(),
            courseManufacturer: _courseManufacturerController.text,
            courseInstructorsIds: [""]);
        await _courseRepository.saveCourse(courseModel);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotoğraf yükleme işlemi başarılı.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Fotoğraf yüklenirken bir hata oluştu.')),
        );
      }
      Navigator.pop(context);
    }
  }

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseStartDateController =
      TextEditingController();
  final TextEditingController _courseEndDateController =
      TextEditingController();
  final TextEditingController _courseManufacturerController =
      TextEditingController();

  List<String> courseNames = [];
  List<CourseModel> courses = [];

  final CourseRepository _courseRepository = CourseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ders Ekle & Düzenle"),
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
                decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        blurRadius: 20,
                      )
                    ],
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Column(
                  children: <Widget>[
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
                    if (selectedImage != null)
                      Text('Fotoğraf seçildi: ${selectedImage!.name}'),
                    TBTInputField(
                      hintText: "Dersin İsmi",
                      controller: _courseNameController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    TBTInputField(
                      hintText: "Dersin Başlangıç Tarihi",
                      controller: _courseStartDateController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    TBTInputField(
                      hintText: "Dersin Bitiş Tarihi",
                      controller: _courseEndDateController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    TBTInputField(
                      hintText: "Üretici Firma",
                      controller: _courseManufacturerController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),

                    // TBTInputField(
                    //     hintText: "Sınıf",
                    //     controller: _classController,
                    //     onSaved: (p0) {},
                    //     keyboardType: TextInputType.multiline),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TBTPurpleButton(
                        buttonText: "Kaydet",
                        onPressed: () {
                          _saveCourse();
                          Navigator.pop(context);
                        },
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
