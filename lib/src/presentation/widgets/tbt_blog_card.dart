import 'package:flutter/material.dart';

import 'package:tobeto/src/models/blog_model.dart';

class TBTBlogCard extends StatefulWidget {
  final BlogModel blogModel;
  final VoidCallback ontap;

  const TBTBlogCard({
    super.key,
    required this.blogModel,
    required this.ontap,
  });

  @override
  State<TBTBlogCard> createState() => _TBTBlogCardState();
}

class _TBTBlogCardState extends State<TBTBlogCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        widget.ontap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color.fromARGB(159, 0, 0, 0), blurRadius: 5),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.network(widget.blogModel.blogImageUrl),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                widget.blogModel.blogCreatedAt.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                widget.blogModel.blogTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.blogModel.blogContent,
                  maxLines: _isExpanded ? null : 4,
                  overflow: _isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}