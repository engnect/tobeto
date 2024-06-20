import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'dart:io';

import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';

class CourseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<CourseModel>> fetchAllCourses() async {
    try {
      final querySnapshot = await _firestore.collection('courses').get();
      return querySnapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching courses: $e');
    }
  }

  Future<List<String>> fetchCourseNames() async {
    QuerySnapshot snapshot = await _firestore.collection('courses').get();
    return snapshot.docs.map((doc) => doc['courseName'] as String).toList();
  }

  Future<List<CourseVideoModel>> fetchCourseVideos(String courseId) async {
    try {
      final querySnapshot = await _firestore
          .collection('videos')
          .where('courseId', isEqualTo: courseId)
          .get();

      return querySnapshot.docs
          .map((doc) => CourseVideoModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching course videos: $e');
    }
  }

  Future<void> addCourse(CourseModel course) async {
    try {
      //await _firestore.collection('courses').doc(course.).set(course.toMap());
    } catch (e) {
      throw Exception('Error adding course: $e');
    }
  }

  Future<void> addCourseVideo(
      String courseId, CourseVideoModel courseVideo) async {
    try {
      await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('videos')
          .add(courseVideo.toMap());
    } catch (e) {
      throw Exception('Error adding course video: $e');
    }
  }

  // Admin panelinde video yüklemek için
  // Future<void> uploadVideoAndSaveUrl(String courseId, File videoFile) async {
  //   try {
  //     // Upload video to Firebase Storage
  //     String filePath =
  //         'videos/$courseId/${DateTime.now().millisecondsSinceEpoch}.mp4';
  //     UploadTask uploadTask = _storage.ref().child(filePath).putFile(videoFile);
  //     TaskSnapshot snapshot = await uploadTask;
  //     String videoUrl = await snapshot.ref.getDownloadURL();

  //     // Save video URL to Firestore
  //     await _firestore
  //         .collection('courses')
  //         .doc(courseId)
  //         .collection('videos')
  //         .add({
  //       'videoUrl': videoUrl,
  //       'courseVideoName': 'Video Name',
  //       'courseInstructor': 'Instructor Name',
  //       'startDate': '2024-01-01',
  //       'endDate': '2024-02-01',
  //       'estimatedDate': '2024-01-15',
  //       'manufacturer': 'Manufacturer Name'
  //     });
  //   } catch (e) {
  //     throw Exception('Error uploading video and saving URL: $e');
  //   }
  // }

  Future<String?> uploadVideoAndSaveUrl(String filePath) async {
    File file = File(filePath);
    try {
      TaskSnapshot snapshot = await _storage
          .ref('videos/${file.path.split('/').last}')
          .putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading video: $e");
      return null;
    }
  }

  Future<void> saveCourseVideo(CourseVideoModel courseVideoModel) async {
    await _firestore
        .collection(FirebaseConstants.videosCollection)
        .doc(courseVideoModel.videoId)
        .set(courseVideoModel.toMap());
  }

  Future<void> editVideo(
      String videoId, String newCourseName, String newCourseId) async {
    try {
      await _firestore.collection('videos').doc(videoId).update({
        'courseName': newCourseName,
        'courseId': newCourseId,
      });
    } catch (e) {
      throw Exception('Error updating video: $e');
    }
  }

  // Admin panelinden ders silmek için
  Future<void> deleteCourse(String courseId) async {
    try {
      await _firestore.collection('courses').doc(courseId).delete();
    } catch (e) {
      throw Exception('Error deleting course: $e');
    }
  }

  Future<void> deleteVideo(String videoId) async {
    try {
      await _firestore.collection('videos').doc(videoId).delete();

      await _storage.ref('videos/$videoId').delete();
    } catch (e) {
      throw Exception('Error deleting course: $e');
    }
  }
}
