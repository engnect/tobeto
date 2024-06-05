import 'package:flutter/material.dart';
import 'package:tobeto/src/models/avatar_model.dart';

class AnimatedAvatar extends StatefulWidget {
  final AvatarModel model;
  const AnimatedAvatar({
    super.key,
    required this.onTab,
    required this.model,
  });
  final VoidCallback onTab;

  @override
  State<AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1300),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0.2),
    end: const Offset(0, 0.5),
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.linear),
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SlideTransition(
        position: _offsetAnimation,
        child: GestureDetector(
          onTap: widget.onTab,
          child: CircleAvatar(
            backgroundImage: AssetImage(widget.model.avatar),
            radius: 45,
            backgroundColor: widget.model.color,
          ),
        ),
      ),
    );
  }
}
