import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class AdminCourseScreen extends StatefulWidget {
  const AdminCourseScreen({super.key});

  @override
  State<AdminCourseScreen> createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Dersler",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Ders Ekle",
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
                  buttonText: "Yeni Ders Ekle",
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRouteNames.adminCourseAddEdit);
                  },
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 200,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseConstants.coursesCollection)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      CourseRepository courseRepository = CourseRepository();
                      TextEditingController courseNameController =
                          TextEditingController();
                      TextEditingController manufacturerController =
                          TextEditingController();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];

                          CourseModel courseModel = CourseModel.fromMap(
                              documentSnapshot.data() as Map<String, dynamic>);

                          String courseId = documentSnapshot.id;

                          void deleteCourse() async {
                            try {
                              await courseRepository
                                  .deleteCourse(courseModel.courseId);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Ders başarıyla silindi')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Ders silinirken bir hata oluştu: $e')),
                              );
                            }
                          }

                          // TODO: implement edilmedi
                          void editCourseFunction() async {
                            String selectedCourseId = courseModel.courseId;

                            try {
                              String newCourseName = courseNameController.text;
                              String newCourseId = selectedCourseId;
                              String manufacturer = manufacturerController.text;

                              await courseRepository.editCourse(
                                  courseId, newCourseName, manufacturer);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Ders başarıyla güncellendi')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Ders güncellenirken bir hata oluştu: $e')),
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
                                    "Seçili Dersi Düzenle",
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
                                                  'Yeni Ders ismini girin.',
                                              controller: courseNameController,
                                              onSaved: (p0) {},
                                              keyboardType:
                                                  TextInputType.multiline,
                                            ),
                                            TBTInputField(
                                              hintText:
                                                  'Ders üretici firma ismini girin.',
                                              controller:
                                                  manufacturerController,
                                              onSaved: (p0) {},
                                              keyboardType:
                                                  TextInputType.multiline,
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
                                      child: Text(
                                        "Değişiklikleri Kaydet",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
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
                                  onPressed: (context) {
                                    deleteCourse();
                                  },
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
                                'Ders adı: ${courseModel.courseName}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
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
