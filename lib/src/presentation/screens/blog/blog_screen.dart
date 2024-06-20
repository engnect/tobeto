import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import '../../widgets/tbt_blog_stream.dart';
import '../../widgets/tbt_drawer_widget.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
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
                          "Blog",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      const TBTBlogStream(
                        isBlog: true,
                      ),
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
