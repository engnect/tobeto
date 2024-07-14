import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';
import '../export_screens.dart';

class AdminCourseVideoScreen extends StatefulWidget {
  const AdminCourseVideoScreen({super.key});

  @override
  State<AdminCourseVideoScreen> createState() => _AdminCourseVideoScreenState();
}

class _AdminCourseVideoScreenState extends State<AdminCourseVideoScreen> {
  final TextEditingController _courseVideoNameController =
      TextEditingController();
  final TextEditingController _editCourseVideoNameController =
      TextEditingController();

  XFile? _selectedVideo;
  bool selected = false;
  VideoPlayerController? _videoPlayerController;
  List<String> courseNames = [];
  List<CourseModel> courses = [];
  String? selectedCourseName;
  String? selectedCourseId;

  @override
  void initState() {
    fetchCourseNames();
    fetchAllCourses();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _courseVideoNameController.dispose();
    _editCourseVideoNameController.dispose();
    super.dispose();
  }

  Future<void> fetchCourseNames() async {
    List<String> names = await CourseRepository().fetchCourseNamesList();
    setState(() {
      courseNames += names;
    });
  }

  Future<void> fetchAllCourses() async {
    List<CourseModel> coursesTest = await CourseRepository().fetchAllCourses();
    setState(() {
      courses += coursesTest;
    });
  }

  Future<void> _getVideoFromGallery() async {
    final XFile? video = await Utilities.getVideoFromGallery();
    if (video != null) {
      _videoPlayerController = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          setState(() {
            _selectedVideo = video;
            selected = true;
          });
          _videoPlayerController!.play();
        });
    }
  }

  Future<void> _addCourseVideo({
    required String selectedCourseId,
    required String courseVideoName,
    required String selectedCourseName,
    required XFile? selectedVideo,
  }) async {
    if (selectedVideo != null && _courseVideoNameController.text.isNotEmpty) {
      String videoId = const Uuid().v1();

      String? videoUrl =
          await FirebaseStorageRepository().uploadCourseVideoAndSaveUrl(
        videoId: selectedCourseId,
        selectedVideo: selectedVideo,
      );

      if (videoUrl != null) {
        CourseVideoModel courseVideoModel = CourseVideoModel(
          videoId: videoId,
          courseId: selectedCourseId,
          courseVideoName: _courseVideoNameController.text,
          courseName: selectedCourseName,
          videoUrl: videoUrl,
        );

        String result =
            await CourseRepository().addOrUpdateCourseVideo(courseVideoModel);

        Utilities.showToast(toastMessage: result);
      }
    }
  }

  void _deleteVideoFunction({
    required String videoId,
  }) async {
    String result = await CourseRepository().deleteVideo(videoId);

    Utilities.showToast(toastMessage: result);
  }

  void _editVideoFunction({
    required BuildContext context,
    required String videoId,
    required String selectedCourseId,
    required String newCourseVideoName,
  }) async {
    String newCourseVideoName = _editCourseVideoNameController.text;
    String newCourseId = selectedCourseId;

    String result = await CourseRepository().editVideo(
        videoId, newCourseVideoName, newCourseId, selectedCourseName!);

    Utilities.showToast(toastMessage: result);
  }

  void _showEditDialog({
    required BuildContext context,
    required String videoId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            "Seçili Videoyu Düzenle",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: StreamBuilder<List<CourseModel>>(
            stream: CourseRepository().fetchAllCoursesAsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses available.'));
              } else {
                List<CourseModel> courses = snapshot.data!;
                List<String> courseNames =
                    courses.map((course) => course.courseName).toList();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TBTInputField(
                      hintText: 'Yeni Video ismini girin.',
                      controller: _editCourseVideoNameController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: Text(
                        "Ders Kategorisi",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      value: selectedCourseName,
                      items: courseNames.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCourseName = newValue;

                          selectedCourseId = courses
                              .firstWhere(
                                  (course) => course.courseName == newValue)
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
                _editVideoFunction(
                    context: context,
                    videoId: videoId,
                    selectedCourseId: selectedCourseId!,
                    newCourseVideoName: _editCourseVideoNameController.text);
                Navigator.pop(context);

                _editCourseVideoNameController.clear();
              },
              child: Text(
                "Değişiklikleri Kaydet",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
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
                      height: 400,
                      infoText: 'Ders Videosu Ekle',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _getVideoFromGallery(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 50,
                                  top: 30,
                                ),
                                child: selected
                                    ? CourseVideo(
                                        dataSourceType: DataSourceType.file,
                                        videoUrl: _selectedVideo!.path,
                                        onFullScreenToggle: (isFullScreen) {},
                                      )
                                    : AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                150, 150, 150, 0.2),
                                          ),
                                          child: const Icon(
                                            Icons.video_call,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            TBTInputField(
                              hintText: 'Ders Video İsmi',
                              controller: _courseVideoNameController,
                              onSaved: (p0) {},
                              keyboardType: TextInputType.multiline,
                            ),
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              hint: Text(
                                "Ders Kategorisi",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              value: selectedCourseName,
                              items: courseNames.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  onTap: () {
                                    selectedCourseName = value;
                                  },
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                selectedCourseName = newValue;
                                selectedCourseId = courses
                                    .firstWhere((course) =>
                                        course.courseName == newValue)
                                    .courseId;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TBTPurpleButton(
                                buttonText: "Kaydet",
                                onPressed: () async {
                                  await _addCourseVideo(
                                    selectedCourseId: selectedCourseId!,
                                    selectedCourseName: selectedCourseName!,
                                    courseVideoName: selectedCourseName!,
                                    selectedVideo: _selectedVideo,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseService()
                        .firebaseFirestore
                        .collection(FirebaseConstants.videosCollection)
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

                            CourseVideoModel courseVideoModel =
                                CourseVideoModel.fromMap(documentSnapshot.data()
                                    as Map<String, dynamic>);

                            return Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                extentRatio: 0.6,
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) =>
                                        _deleteVideoFunction(
                                      videoId: courseVideoModel.videoId,
                                    ),
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Sil',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      _showEditDialog(
                                          context: context,
                                          videoId: courseVideoModel.videoId);
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
                                  'Video adı: ${courseVideoModel.courseVideoName}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
    );
  }
}
