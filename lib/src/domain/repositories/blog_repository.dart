import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/models/blog_model.dart';

import '../../common/constants/firebase_constants.dart';

class BlogRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _blogs =>
      _firebaseFirestore.collection(FirebaseConstants.blogsCollection);

  Future<List<BlogModel>> fetchBlogsFromFirestore() async {
    List<BlogModel> blogs = [];
    var querySnapshot = await _blogs.get();
    for (var doc in querySnapshot.docs) {
      blogs.add(BlogModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return blogs;
  }

  Future<String> addBlog({
    required BlogModel blogModel,
  }) async {
    String result = '';

    try {
      await _blogs.add(blogModel.toMap());
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return result;
  }

  Future<String> updateBlog({
    required BlogModel blogModel,
  }) async {
    String result = '';

    try {
      await _blogs.doc(blogModel.blogId).set(blogModel);
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return result;
  }

  Future<String> deleteEvent({
    required BlogModel blogModel,
  }) async {
    String result = '';

    try {
      await _blogs.doc(blogModel.blogId).delete();
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return result;
  }
}
