import 'package:flutter/material.dart';

class TBTAnimatedContainer extends StatefulWidget {
  final double height;
  final String infoText;
  final Widget child;

  const TBTAnimatedContainer({
    super.key,
    required this.height,
    required this.infoText,
    required this.child,
  });

  @override
  State<TBTAnimatedContainer> createState() => _TBTAnimatedContainerState();
}

class _TBTAnimatedContainerState extends State<TBTAnimatedContainer> {
  bool isExpanded = false;
  ScrollController animatedContScrllCntrllr = ScrollController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: isExpanded == true
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                : null,
            border: Border(
              bottom: isExpanded
                  ? BorderSide(
                      width: isExpanded == true ? 7 : 0,
                      color: const Color.fromARGB(255, 153, 51, 255),
                    )
                  : BorderSide.none,
            ),
          ),
          height: isExpanded ? widget.height : 0,
          duration: const Duration(seconds: 1),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbVisibility: MaterialStateProperty.all(true),
              trackVisibility: MaterialStateProperty.all(true),
              thickness: MaterialStateProperty.all(3.0),
              thumbColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 153, 51, 255)),
            ),
            child: Scrollbar(
              controller: animatedContScrllCntrllr,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: animatedContScrllCntrllr,
                  primary: false,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
        //
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: isExpanded == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_up_outlined,
                      size: 50,
                      color: Color.fromARGB(255, 153, 51, 255),
                    ),
                    Text(
                      widget.infoText,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 50,
                      color: Color.fromARGB(255, 153, 51, 255),
                    ),
                    Text(
                      widget.infoText,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
