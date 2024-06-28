import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Color.fromARGB(159, 0, 0, 0), blurRadius: 5),
          ],
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                DateFormat('dd/MM/yyyy').format(widget.blogModel.blogCreatedAt),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
