import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

import '../../../../../common/constants/firebase_constants.dart';
import '../../../../../models/blog_model.dart';

/*




!!!!!!!!!!!!!!!!!!!!!!!!
Önemli Basında biz Sayfası ile Blog Sayfası aynı model üzerinden firebase e
Göndereceğimiz için bu sayfada Basında biz Model ve Verileri Kullanılmıştır.
İlgili Arkadaşların Dikkatine !!!!!!!!!!!!!!



 */

class BlogPageAdmin extends StatefulWidget {
  const BlogPageAdmin({
    super.key,
  });

  @override
  State<BlogPageAdmin> createState() => _BlogPageAdminState();
}

class _BlogPageAdminState extends State<BlogPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
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
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.7), blurRadius: 20)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: TBTPurpleButton(
                    buttonText: "Yeni Blog Ekle",
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(
                          AppRouteNames.inThePressAddEditScreenRoute);
                    },
                  ),
                ),
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 200,
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
                                documentSnapshot.data()
                                    as Map<String, dynamic>);
                            return Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                extentRatio: 0.6,
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      print("Sile tıklandı");
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Sil',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      print("Düzenleye tıklandı");
                                    },
                                    backgroundColor: const Color(0xFF21B7CA),
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Düzenle',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(blogModel.blogImageUrl),
                                ),
                                title: Text(blogModel.blogTitle),
                                subtitle: Text(blogModel.blogContent),
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
        ],
      ),
    ));
  }
}