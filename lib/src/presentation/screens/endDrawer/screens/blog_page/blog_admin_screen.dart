import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_slideable_list_tile.dart';

import '../../../../../common/constants/firebase_constants.dart';
import '../../../../../models/blog_model.dart';

class AdminBlogScreen extends StatefulWidget {
  const AdminBlogScreen({
    super.key,
  });

  @override
  State<AdminBlogScreen> createState() => _AdminBlogScreenState();
}

class _AdminBlogScreenState extends State<AdminBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Blog"),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Blogları Düzenle",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: TBTPurpleButton(
                buttonText: "Yeni Blog Ekle",
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(
                      AppRouteNames.inThePressAddEditScreenRoute);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight - 200,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirebaseConstants.blogsCollection)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                        BlogModel blogModel = BlogModel.fromMap(
                            documentSnapshot.data() as Map<String, dynamic>);
                        return TBTSlideableListTile(
                          imgUrl: blogModel.blogImageUrl,
                          title: blogModel.blogTitle,
                          subtitle: blogModel.blogContent,
                          deleteOnPressed: (p0) {},
                          editOnPressed: (p0) {},
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
    );
  }
}
