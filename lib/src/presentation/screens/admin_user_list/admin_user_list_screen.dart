import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        body: StreamBuilder(
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];

                  UserModel userModel = UserModel.fromMap(
                      documentSnapshot.data() as Map<String, dynamic>);

                  return ListTile(
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
