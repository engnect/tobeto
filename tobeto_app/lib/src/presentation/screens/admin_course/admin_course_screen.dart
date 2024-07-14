import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:uuid/uuid.dart';
import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

class AdminCourseScreen extends StatefulWidget {
  const AdminCourseScreen({super.key});

  @override
  State<AdminCourseScreen> createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCourseScreen> {
  CourseRepository courseRepository = CourseRepository();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  XFile? _selectedImage;
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
      setState(
        () {
          _selectedImage = file;
          selected = true;
        },
      );
    }
  }

  void _addCourse({
    required String courseName,
    required DateTime startDate,
    required DateTime endDate,
    required String manufacturer,
  }) async {
    List<String> adminIdsList = await UserRepository().getAdminIds();
    UserModel? currentUser = await UserRepository().getCurrentUser();
    List<String?> courseInstructorsIds = [];
    if (currentUser!.userRank == UserRank.instructor) {
      courseInstructorsIds.add(currentUser.userId);
    }
    courseInstructorsIds += adminIdsList;

    String courseId = const Uuid().v1();
    String? courseThumbnailUrl = await FirebaseStorageRepository()
        .uploadCourseThumbnailsAndSaveUrl(
            selectedCourseThumbnail: _selectedImage);
    CourseModel courseModel = CourseModel(
      courseId: courseId,
      courseThumbnailUrl: courseThumbnailUrl!,
      courseName: courseName,
      courseStartDate: selectedStartDate!,
      courseEndDate: selectedEndDate!,
      courseManufacturer: manufacturer,
      courseInstructorsIds: courseInstructorsIds,
    );

    String result = await CourseRepository().addCourse(courseModel);

    Utilities.showToast(toastMessage: result);
  }

  void _deleteCourse({
    required String videoId,
    required BuildContext context,
  }) async {
    PanaraConfirmDialog.showAnimatedFade(
      context,
      title: 'Dikkat!',
      message: 'İçeriği KALICI olarak silmek istediğinize eminmisiniz?',
      confirmButtonText: 'Sil!',
      cancelButtonText: 'İptal!',
      onTapConfirm: () async {
        String result = await courseRepository.deleteCourse(videoId);

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

  void _editCourseFunction({
    required String selectedCourseId,
    required String newCourseName,
    required String newManufacturer,
  }) async {
    String result = await courseRepository.editCourse(
        selectedCourseId, newCourseName, newManufacturer);
    Utilities.showToast(toastMessage: result);
  }

  void _showEditDialog(
      {required BuildContext context, required String courseId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            "Seçili Dersi Düzenle",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: StreamBuilder<List<CourseModel>>(
            stream: courseRepository.fetchAllCoursesAsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses available.'));
              } else {
                return Column(
                  children: [
                    TBTInputField(
                      hintText: 'Yeni Ders ismini girin.',
                      controller: _editCourseNameController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    TBTInputField(
                      hintText: 'Ders üretici firma ismini girin.',
                      controller: _editManufacturerController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "İptal",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _editCourseFunction(
                  selectedCourseId: courseId,
                  newCourseName: _editCourseNameController.text,
                  newManufacturer: _editManufacturerController.text,
                );
                Navigator.pop(context);
              },
              child: Text(
                "Değişiklikleri Kaydet",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        );
      },
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
                    child: TBTAnimatedContainer(
                      height: 420,
                      infoText: "Ders Ekle & Düzenle",
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        150, 150, 150, 0.2),
                                    image: selected
                                        ? DecorationImage(
                                            image: FileImage(
                                              File(_selectedImage!.path),
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  icon:
                                      const Icon(Icons.calendar_today_outlined),
                                  onPressed: () async {
                                    selectedStartDate =
                                        await Utilities.datePicker(context);
                                    setState(() {});
                                  },
                                  label: Text(
                                    style: const TextStyle(fontSize: 10),
                                    selectedStartDate == null
                                        ? 'Başlangıç Tarihi'
                                        : DateFormat('dd/MM/yyyy')
                                            .format(selectedStartDate!),
                                  ),
                                ),
                                TextButton.icon(
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () async {
                                    selectedEndDate =
                                        await Utilities.datePicker(context);
                                    setState(() {});
                                  },
                                  label: Text(
                                    style: const TextStyle(fontSize: 10),
                                    selectedEndDate == null
                                        ? 'Bitiş Tarihi'
                                        : DateFormat('dd/MM/yyyy')
                                            .format(selectedEndDate!),
                                  ),
                                ),
                              ],
                            ),
                            TBTPurpleButton(
                              buttonText: "Ders Ekle",
                              onPressed: () => _addCourse(
                                courseName: _courseNameController.text,
                                startDate: selectedStartDate!,
                                endDate: selectedEndDate!,
                                manufacturer: _manufacturerController.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseService()
                        .firebaseFirestore
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

                            return TBTSlideableListTile(
                              imgUrl: courseModel.courseThumbnailUrl,
                              title: 'Ders adı: ${courseModel.courseName}',
                              subtitle: courseModel.courseManufacturer,
                              deleteOnPressed: (p0) {
                                _deleteCourse(
                                    videoId: courseModel.courseId,
                                    context: context);
                              },
                              editOnPressed: (p0) {
                                _showEditDialog(
                                    context: context,
                                    courseId: courseModel.courseId);
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
