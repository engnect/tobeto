import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class AdminCourseVideoScreen extends StatefulWidget {
  const AdminCourseVideoScreen({super.key});

  @override
  State<AdminCourseVideoScreen> createState() => _AdminCourseVideoScreenState();
}

class _AdminCourseVideoScreenState extends State<AdminCourseVideoScreen> {
  final TextEditingController _editCourseVideoNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Dersler"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Ders Videosu Ekle",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TBTPurpleButton(
                  buttonText: "Yeni Ders Videosu Ekle",
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRouteNames.adminCourseVideoAddEdit);
                  },
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 200,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseConstants.videosCollection)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      CourseRepository courseRepository = CourseRepository();

                      String? selectedCourseName;
                      String selectedCourseId = "";

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];

                          CourseVideoModel courseVideoModel =
                              CourseVideoModel.fromMap(documentSnapshot.data()
                                  as Map<String, dynamic>);

                          String videoId = documentSnapshot.id;

                          void deleteVideoFunction() async {
                            try {
                              await courseRepository.deleteVideo(videoId);

                              if (!context.mounted) return;
                              Utilities.showSnackBar(
                                  snackBarMessage: 'Video başarıyla silindi',
                                  context: context);
                            } catch (e) {
                              Utilities.showSnackBar(
                                  snackBarMessage:
                                      'Video silinirken bir hata oluştu: $e',
                                  context: context);
                            }
                          }

                          void editVideoFunction() async {
                            try {
                              String newCourseVideoName =
                                  _editCourseVideoNameController.text;
                              String newCourseId = selectedCourseId;

                              await courseRepository.editVideo(
                                  videoId,
                                  newCourseVideoName,
                                  newCourseId,
                                  selectedCourseName!);

                              if (!context.mounted) return;
                              Utilities.showSnackBar(
                                  snackBarMessage:
                                      'Video başarıyla güncellendi',
                                  context: context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Video güncellenirken bir hata oluştu: $e')),
                              );
                            }
                          }

                          void showEditDialog(BuildContext context) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  title: Text(
                                    "Seçili Videoyu Düzenle",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  content: StreamBuilder<List<CourseModel>>(
                                    stream: courseRepository.fetchAllCourses(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child:
                                                Text('No courses available.'));
                                      } else {
                                        List<CourseModel> courses =
                                            snapshot.data!;
                                        List<String> courseNames = courses
                                            .map((course) => course.courseName)
                                            .toList();

                                        return Column(
                                          children: [
                                            TBTInputField(
                                              hintText:
                                                  'Yeni Video ismini girin.',
                                              controller:
                                                  _editCourseVideoNameController,
                                              onSaved: (p0) {},
                                              keyboardType:
                                                  TextInputType.multiline,
                                            ),
                                            DropdownButtonFormField<String>(
                                              isExpanded: true,
                                              hint:
                                                  const Text("Ders Kategorisi"),
                                              value: selectedCourseName,
                                              items: courseNames
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedCourseName = newValue;

                                                  selectedCourseId = courses
                                                      .firstWhere((course) =>
                                                          course.courseName ==
                                                          newValue)
                                                      .courseId;
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        editVideoFunction();
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Text("Değişiklikleri Kaydet"),
                                    ),
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
                                  onPressed: (context) => deleteVideoFunction(),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Sil',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showEditDialog(context);
                                  },
                                  backgroundColor: const Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Düzenle',
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                  'Video adı: ${courseVideoModel.courseVideoName}'),
                            ),
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
