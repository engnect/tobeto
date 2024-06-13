import 'package:flutter/material.dart';
import '../../widgets/tbt_app_bar_widget.dart';
import '../../widgets/tbt_blog_stream.dart';
import '../../widgets/tbt_drawer_widget.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final ScrollController _controller = ScrollController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TBTAppBar(controller: _controller),
        drawer: const TBTDrawer(),
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: SingleChildScrollView(
          controller: _controller,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  "Blog",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
              TBTBlogStream(
                isBlog: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
