import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/export_domain.dart';

import '../../../../common/constants/firebase_constants.dart';
import '../../../../models/blog_model.dart';
import 'tbt_blog_card.dart';

class TBTBlogStream extends StatelessWidget {
  final bool isBlog;

  const TBTBlogStream({
    super.key,
    required this.isBlog,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseService()
          .firebaseFirestore
          .collection(isBlog
              ? FirebaseConstants.blogsCollection
              : FirebaseConstants.inThePressCollection)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];

              BlogModel blogModel = BlogModel.fromMap(
                  documentSnapshot.data() as Map<String, dynamic>);

              return TBTBlogCard(
                blogModel: blogModel,
                ontap: () {},
              );
            },
          );
        }
      },
    );
  }
}
