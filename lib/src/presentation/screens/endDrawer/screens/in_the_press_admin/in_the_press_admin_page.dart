import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/domain/repositories/blog_repository.dart';
import 'package:tobeto/src/models/blog_model.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

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
    blogs = await BlogRepository().fetchBlogsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(blogs);
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.7), blurRadius: 20)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TBTPurpleButton(
                      buttonText: "Yeni İçerik Ekle",
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(
                            AppRouteNames.inThePressAddEditScreenRoute);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        200,
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
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 2,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              blogModel.blogImageUrl),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  blogModel.blogTitle,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  textAlign: TextAlign.left,
                                                  blogModel.blogCreatedAt
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    color: Color.fromRGBO(
                                                      135,
                                                      135,
                                                      135,
                                                      1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  textAlign: TextAlign.left,
                                                  blogModel.blogContent,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(
                                                      135,
                                                      135,
                                                      135,
                                                      1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
      ),
    );
  }
}
