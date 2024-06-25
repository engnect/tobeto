import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';

class CourseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CollectionReference get _courses =>
      _firestore.collection(FirebaseConstants.coursesCollection);
  CollectionReference get _videos =>
      _firestore.collection(FirebaseConstants.videosCollection);

  Stream<List<CourseModel>> fetchAllCoursesAsStream() {
    return _firestore
        .collection(FirebaseConstants.coursesCollection)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => CourseModel.fromMap(
                doc.data(),
              ),
            )
            .toList();
      },
    );
  }

  Future<List<CourseModel>> fetchAllCourses() async {
    List<DocumentSnapshot> coursesDocumentSnapshots = [];
    List<CourseModel> courses = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseConstants.coursesCollection)
        .get();

    coursesDocumentSnapshots = querySnapshot.docs;
    for (var i = 0; i < coursesDocumentSnapshots.length; i++) {
      CourseModel courseModel = CourseModel.fromMap(
          coursesDocumentSnapshots[i].data() as Map<String, dynamic>);
      courses.add(courseModel);
    }

    return courses;
  }

  Stream<List<String>> fetchCourseNames() {
    return _firestore
        .collection(FirebaseConstants.coursesCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc['courseName'] as String).toList();
    });
  }

  Future<List<String>> fetchCourseNamesList() async {
    List<DocumentSnapshot> courseNamesDocumentSnapshots = [];
    List<String> courseNamesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseConstants.coursesCollection)
        .get();

    courseNamesDocumentSnapshots = querySnapshot.docs;
    for (var i = 0; i < courseNamesDocumentSnapshots.length; i++) {
      CourseModel courseModel = CourseModel.fromMap(
          courseNamesDocumentSnapshots[i].data() as Map<String, dynamic>);
      courseNamesList.add(courseModel.courseName);
    }

    return courseNamesList;
  }

  Future<List<CourseVideoModel>> fetchCourseVideos(String courseId) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseConstants.videosCollection)
          .where('courseId', isEqualTo: courseId)
          .get();

      return querySnapshot.docs
          .map(
            (doc) => CourseVideoModel.fromMap(
              doc.data(),
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Error fetching course videos: $e');
    }
  }
  // Admin panelinde ders eklemek için

  Future<String> addCourse(CourseModel courseModel) async {
    String result = '';
    try {
      await _courses.doc(courseModel.courseId).set(courseModel.toMap());
      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  // Admin panelinden video eklemek ve düzenlemek için
  Future<String> addOrUpdateCourseVideo(
      CourseVideoModel courseVideoModel) async {
    String result = '';
    try {
      await _videos.doc(courseVideoModel.videoId).set(courseVideoModel.toMap());
      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  // Admin panelinde ders düzenlemek için
  Future<String> editCourse(
    String courseId,
    String newCourseName,
    String manufacturer,
  ) async {
    String result = '';
    try {
      await _courses.doc(courseId).update(
        {
          'courseName': newCourseName,
          'manufacturer': manufacturer,
        },
      );
      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  // Admin panelinde video düzenlemek için
  Future<String> editVideo(String videoId, String newCourseVideoName,
      String newCourseId, String newCourseName) async {
    String result = '';
    try {
      await _videos.doc(videoId).update(
        {
          'courseVideoName': newCourseVideoName,
          'courseId': newCourseId,
          'courseName': newCourseName,
        },
      );

      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  // Admin panelinden ders silmek için
  Future<String> deleteCourse(String courseId) async {
    String result = '';
    try {
      await _courses.doc(courseId).delete();
      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  // Admin panelinden video silmek için
  Future<String> deleteVideo(String videoId) async {
    String result = '';
    try {
      await _videos.doc(videoId).delete();
      await _storage.ref('videos/$videoId').delete();
      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return Utilities.errorMessageChecker(result);
  }
}
