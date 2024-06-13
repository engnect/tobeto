// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TBTAnimatedContainer extends StatefulWidget {
  final double height;
  bool isExpanded;
  final Widget child;
  TBTAnimatedContainer({
    super.key,
    required this.height,
    required this.isExpanded,
    required this.child,
  });

  @override
  State<TBTAnimatedContainer> createState() => _TBTAnimatedContainerState();
}

class _TBTAnimatedContainerState extends State<TBTAnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    bool isExp = widget.isExpanded;
    return Column(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: widget.isExpanded
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                : null,
            border: isExp
                ? Border(
                    bottom: BorderSide(
                      width: widget.isExpanded ? 7 : 0,
                      color: const Color.fromARGB(255, 153, 51, 255),
                    ),
                  )
                : null,
          ),
          height: widget.isExpanded ? widget.height : 0,
          duration: const Duration(seconds: 1),
          child: SingleChildScrollView(child: widget.child),
        ),
        //
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isExpanded = !widget.isExpanded;
            });
          },
          child: widget.isExpanded
              ? const Icon(
                  Icons.keyboard_arrow_up_outlined,
                  size: 50,
                  color: Color.fromARGB(255, 153, 51, 255),
                )
              : const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 50,
                  color: Color.fromARGB(255, 153, 51, 255),
                ),
        ),
      ],
    );
  }
}
