import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_admin_sliver_app_bar.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import 'package:uuid/uuid.dart';

class AdminCourseScreen extends StatefulWidget {
  const AdminCourseScreen({super.key});

  @override
  State<AdminCourseScreen> createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCourseScreen> {
  CourseRepository courseRepository = CourseRepository();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  XFile? selectedImage;
  bool selected = false;

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _editCourseNameController =
      TextEditingController();
  final TextEditingController _editManufacturerController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _courseNameController.dispose();
    _manufacturerController.dispose();
    _editCourseNameController.dispose();
    _editManufacturerController.dispose();
  }

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

  void addCourse(BuildContext context) async {
    String courseId = const Uuid().v1();
    String? courseThumbnailUrl = await FirebaseStorageRepository()
        .uploadCourseThumbnailsAndSaveUrl(
            selectedCourseThumbnail: selectedImage);
    CourseModel courseModel = CourseModel(
        courseId: courseId,
        courseThumbnailUrl: courseThumbnailUrl!,
        courseName: _courseNameController.text,
        courseStartDate: selectedStartDate!,
        courseEndDate: selectedEndDate!,
        courseManufacturer: _manufacturerController.text,
        courseInstructorsIds: ["1", "2"]);

    String result = await CourseRepository().addCourse(courseModel);

    if (!context.mounted) return;
    Utilities.showSnackBar(
      snackBarMessage: result,
      context: context,
    );
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Ders Ekle & Düzenle",
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
                          infoText: "Ders Ekle",
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, top: 30),
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
                              TBTInputField(
                                hintText: 'Ders İsmi',
                                controller: _courseNameController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline,
                              ),
                              TBTInputField(
                                hintText: 'Üretici Firma',
                                controller: _manufacturerController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline,
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.calendar_today_outlined),
                                onPressed: () async {
                                  selectedStartDate =
                                      await Utilities.datePicker(context);

                                  setState(() {});
                                },
                                label: Text(
                                  selectedStartDate == null
                                      ? 'Başlangıç Tarihi Seç'
                                      : DateFormat('dd/MM/yyyy')
                                          .format(selectedStartDate!),
                                ),
                              ),
                              TextButton.icon(
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () async {
                                  selectedEndDate =
                                      await Utilities.datePicker(context);

                                  setState(() {});
                                },
                                label: Text(
                                  selectedEndDate == null
                                      ? 'Bitiş Tarihi Seç'
                                      : DateFormat('dd/MM/yyyy')
                                          .format(selectedEndDate!),
                                ),
                              ),
                              // TBTInputField(
                              //   hintText: 'Kurs Eğitmenleri',
                              //   controller: _manufacturerController,
                              //   onSaved: (p0) {},
                              //   keyboardType: TextInputType.multiline,
                              // ),
                              TBTPurpleButton(
                                buttonText: "Ders Ekle",
                                onPressed: () => addCourse(context),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseConstants.coursesCollection)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];

                                  CourseModel courseModel = CourseModel.fromMap(
                                      documentSnapshot.data()
                                          as Map<String, dynamic>);

                                  String courseId = documentSnapshot.id;

                                  void deleteCourse() async {
                                    try {
                                      await courseRepository
                                          .deleteCourse(courseModel.courseId);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Ders başarıyla silindi')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Ders silinirken bir hata oluştu: $e')),
                                      );
                                    }
                                  }

                                  void editCourseFunction() async {
                                    String selectedCourseId =
                                        courseModel.courseId;

                                    // TODO: Course Instructors kısmını ekle
                                    // ve buradan gönder ayrıca courseRepository'de de ekleme ve düzenleme kısmına ekle

                                    String newCourseName =
                                        _editCourseNameController.text;

                                    String manufacturer =
                                        _editManufacturerController.text;

                                    String result =
                                        await courseRepository.editCourse(
                                            selectedCourseId,
                                            newCourseName,
                                            manufacturer);
                                    if (!context.mounted) return;
                                    Utilities.showSnackBar(
                                        snackBarMessage: result,
                                        context: context);
                                  }

                                  void showEditDialog(BuildContext context) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Seçili Dersi Düzenle",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                          content:
                                              StreamBuilder<List<CourseModel>>(
                                            stream: courseRepository
                                                .fetchAllCourses(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                        'No courses available.'));
                                              } else {
                                                return Column(
                                                  children: [
                                                    TBTInputField(
                                                      hintText:
                                                          'Yeni Ders ismini girin.',
                                                      controller:
                                                          _editCourseNameController,
                                                      onSaved: (p0) {},
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                    ),
                                                    TBTInputField(
                                                      hintText:
                                                          'Ders üretici firma ismini girin.',
                                                      controller:
                                                          _editManufacturerController,
                                                      onSaved: (p0) {},
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                editCourseFunction();
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  Text("Değişiklikleri Kaydet",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      )),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }

                                  return Slidable(
                                    key: ValueKey(index),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.6,
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            deleteCourse();
                                          },
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Sil',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            showEditDialog(context);
                                          },
                                          backgroundColor:
                                              const Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'Düzenle',
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        'Ders adı: ${courseModel.courseName}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
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
          ],
        ),
      ),
    );
  }
}
