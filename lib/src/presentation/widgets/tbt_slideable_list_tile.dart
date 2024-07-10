import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TBTSlideableListTile extends StatelessWidget {
  final String? imgUrl;
  final String title;
  final String subtitle;
  final Function(BuildContext) deleteOnPressed;
  final Function(BuildContext) editOnPressed;
  final Function()? onTap;

  const TBTSlideableListTile({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subtitle,
    required this.deleteOnPressed,
    required this.editOnPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.55,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: deleteOnPressed,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
          ),
          SlidableAction(
            onPressed: editOnPressed,
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Düzenle',
          ),
        ],
      ),
      child: ListTile(
        leading: imgUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(imgUrl!),
              )
            : const SizedBox(),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
