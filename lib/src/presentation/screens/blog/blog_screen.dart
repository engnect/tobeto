import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/presentation/screens/blog/blog_module.dart';
import '../../widgets/export_widgets.dart';

class BlogScreen extends StatefulWidget {
  final bool isBlog;
  const BlogScreen({
    super.key,
    required this.isBlog,
  });

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    final netStatusCubit = context.watch<NetConnectionCubit>().state;
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.isBlog ? "Blog" : 'Basında Biz',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      netStatusCubit
                          ? TBTBlogStream(
                              isBlog: widget.isBlog,
                            )
                          : const Text('İnternet bağlantısı yok!'),
                    ],
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
