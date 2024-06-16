import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/models/blog_model.dart';

import '../../common/constants/firebase_constants.dart';

class BlogRepository {
  final bool isBlog;
  BlogRepository({required this.isBlog});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _blogs =>
      _firebaseFirestore.collection(FirebaseConstants.blogsCollection);
  CollectionReference get _inThePress =>
      _firebaseFirestore.collection(FirebaseConstants.inThePressCollection);

  Future<List<BlogModel>> fetchBlogsFromFirestore() async {
    List<BlogModel> blogs = [];
    if (isBlog == true) {
      var querySnapshot = await _blogs.get();
      for (var doc in querySnapshot.docs) {
        blogs.add(BlogModel.fromMap(doc.data() as Map<String, dynamic>));
      }
    } else {
      var querySnapshot = await _inThePress.get();
      for (var doc in querySnapshot.docs) {
        blogs.add(BlogModel.fromMap(doc.data() as Map<String, dynamic>));
      }
    }

    return blogs;
  }

  // Future<String> addBlog({
  //   required BlogModel blogModel,
  // }) async {
  //   String result = '';
  //   if (isBlog == true) {
  //     try {
  //       await _blogs.add(blogModel.toMap());
  //       result = 'success';
  //     } catch (error) {
  //       result = error.toString();
  //     }
  //   } else {
  //     try {
  //       await _inThePress.add(blogModel.toMap());
  //       result = 'success';
  //     } catch (error) {
  //       result = error.toString();
  //     }
  //   }

  //   return result;
  // }

  Future<String> addOrUpdateBlog({
    required BlogModel blogModel,
  }) async {
    String result = '';

    if (isBlog == true) {
      try {
        await _blogs.doc(blogModel.blogId).set(blogModel);
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    } else {
      try {
        await _inThePress.doc(blogModel.blogId).set(blogModel);
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    }
    return result;
  }

  Future<String> deleteBlog({
    required BlogModel blogModel,
  }) async {
    String result = '';

    if (isBlog == true) {
      try {
        await _blogs.doc(blogModel.blogId).delete();
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    } else {
      try {
        await _inThePress.doc(blogModel.blogId).delete();
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    }
    return result;
  }
}
