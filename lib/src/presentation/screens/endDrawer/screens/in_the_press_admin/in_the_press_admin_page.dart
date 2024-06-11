import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/domain/repositories/blog_repository.dart';
import 'package:tobeto/src/models/blog_model.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

import '../../../../widgets/tbt_slideable_list_tile.dart';

class InThePressAdmin extends StatefulWidget {
  const InThePressAdmin({
    super.key,
  });

  @override
  State<InThePressAdmin> createState() => _InThePressAdminState();
}

class _InThePressAdminState extends State<InThePressAdmin> {
  List<BlogModel> blogs = [];

  @override
  void initState() {
    super.initState();
    getBlogs();
  }

  void getBlogs() async {
    blogs = await BlogRepository(isBlog: true).fetchBlogsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Basında Biz"),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "İçeriği Düzenle",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: TBTPurpleButton(
                buttonText: "Yeni İçerik Ekle",
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(
                      AppRouteNames.inThePressAddEditScreenRoute);
                },
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.inThePressCollection)
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
          ],
        ),
      ),
    );
  }
}
