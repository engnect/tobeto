import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/export_common.dart';

import '../../../models/export_models.dart';

class UserListScreen extends StatefulWidget {
  final int userRankIndex;
  const UserListScreen({
    super.key,
    required this.userRankIndex,
  });

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Kullanıcılar"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 200,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseConstants.usersCollection)
                      .where(
                        'userRank',
                        isEqualTo: widget.userRankIndex,
                      )
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

                          UserModel userModel = UserModel.fromMap(
                              documentSnapshot.data() as Map<String, dynamic>);

                          return Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              extentRatio: 0.6,
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    if (kDebugMode) {
                                      print("Sile tıklandı");
                                    }
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Sil',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    if (kDebugMode) {
                                      print("Düzenleye tıklandı");
                                    }
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
                                backgroundImage: NetworkImage(
                                  userModel.userAvatarUrl!,
                                ),
                              ),
                              title: Text(
                                '${userModel.userName} ${userModel.userSurname}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              subtitle: Text(
                                userModel.userRank!.toNameCapitalize(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
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
      ),
    );
  }
}
