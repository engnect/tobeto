import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/about_us/about_us_screen.dart';
import '../../widgets/tbt_app_bar_widget.dart';
import '../../widgets/tbt_blog_stream.dart';
import '../../widgets/tbt_drawer_widget.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

final ScrollController controller = ScrollController();

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TBTAppBar(controller: controller),
        drawer: const TBTDrawer(),
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Text(
                "Basında Biz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
            Expanded(
              child: TBTBlogStream(
                isBlog: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
