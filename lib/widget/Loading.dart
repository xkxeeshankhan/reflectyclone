import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';

class Loading extends StatefulWidget {
  final double size;
  final Color color;
  final bool showingOnGradient;
  const Loading({Key key, this.size, this.color, this.showingOnGradient=false}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Icon(
        Icons.refresh,
        size: widget.size,
        color: widget.showingOnGradient?  widget.color ?? Colors.white:endingColor,
      ),
    );
  }
}
