import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class CourseVideoAddEdit extends StatefulWidget {
  const CourseVideoAddEdit({super.key});

  @override
  State<CourseVideoAddEdit> createState() => _CourseVideoAddEditState();
}

class _CourseVideoAddEditState extends State<CourseVideoAddEdit> {
  void _pickVideo() async {
    final videoPicker = ImagePicker();
    XFile? file = await videoPicker.pickVideo(source: ImageSource.gallery);

    if (file != null) {
      _videoPlayerController = VideoPlayerController.file(File(file.path))
        ..initialize().then((_) {
          setState(() {
            selectedVideo = file;
            selected = true;
          });
          _videoPlayerController!.play();
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

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

  void _saveCourseVideo() async {
    if (selectedVideo != null &&
        selectedCourseName != null &&
        _courseVideoNameController.text.isNotEmpty) {
      String? videoUrl = await FirebaseStorageRepository()
          .uploadCourseVideoAndSaveUrl(selectedVideo!.path);
      if (videoUrl != null) {
        CourseVideoModel courseVideoModel = CourseVideoModel(
          videoId: const Uuid().v1(),
          courseId: selectedCourseId!,
          courseVideoName: _courseVideoNameController.text,
          courseName: selectedCourseName!,
          videoUrl: videoUrl,
        );
        await _courseRepository.saveCourseVideo(courseVideoModel);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video yükleme işlemi başarılı.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video yüklenirken bir hata oluştu.')),
        );
      }
      Navigator.pop(context);
    }
  }

  final TextEditingController _courseVideoNameController =
      TextEditingController();

  // TextEditingController _classController = TextEditingController();
  XFile? selectedVideo;
  bool selected = false;
  VideoPlayerController? _videoPlayerController;
  final _formKey = GlobalKey<FormState>();
  List<String> courseNames = [];
  List<CourseModel> courses = [];
  String? selectedCourseName;
  String? selectedCourseId;
  final CourseRepository _courseRepository = CourseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ekle & Düzenle",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
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
                        _pickVideo();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50, top: 30),
                        child: CircleAvatar(
                          radius: 50,
                          child: selected
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController!),
                                )
                              : const Icon(
                                  Icons.video_call,
                                  size: 32,
                                ),
                        ),
                      ),
                    ),
                    if (selectedVideo != null)
                      Text('Video seçildi: ${selectedVideo!.name}'),
                    TBTInputField(
                        hintText: "Ders Videosunun İsmi",
                        controller: _courseVideoNameController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline),
                    DropdownButtonFormField<String>(
                      dropdownColor: Theme.of(context).colorScheme.background,
                      isExpanded: true,
                      hint: const Text("Ders Kategorisi"),
                      value: selectedCourseName,
                      items: courseNames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      }).toList(),
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
                          _saveCourseVideo();
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
