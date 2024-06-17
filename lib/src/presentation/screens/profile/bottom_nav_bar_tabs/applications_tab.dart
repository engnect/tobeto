import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';

class ApplicationsTab extends StatefulWidget {
  const ApplicationsTab({super.key});

  @override
  State<ApplicationsTab> createState() => _ApplicationsTabState();
}

class _ApplicationsTabState extends State<ApplicationsTab> {
  bool isExpanded = false;
  final ScrollController _controller = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TBTAppBar(controller: _controller),
      body: Column(
        children: [
          TBTPurpleButton(
            buttonText: 'Yeni Başvuru Yap!',
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          TBTAnimatedContainer(
            height: 300,
            isExpanded: isExpanded,
            child: Column(
              children: [
                TBTInputField(
                  hintText: 'hintText',
                  controller: _textEditingController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
