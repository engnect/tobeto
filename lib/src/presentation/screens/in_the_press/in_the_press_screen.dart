import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/tbt_blog_stream.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';

class InThePressScreen extends StatefulWidget {
  const InThePressScreen({super.key});

  @override
  State<InThePressScreen> createState() => _InThePressScreenState();
}

class _InThePressScreenState extends State<InThePressScreen> {
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
        drawer: const TBTDrawer(),
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SingleChildScrollView(
                    controller: _controller,
                    child: const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
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
                        TBTBlogStream(isBlog: false),
                      ],
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
