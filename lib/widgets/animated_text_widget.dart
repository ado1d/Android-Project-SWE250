import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  final String text;
  final double startSize;
  final double endSize;
  final Color startColor;
  final Color endColor;
  final Duration duration;

  const AnimatedTextWidget({
    Key? key,
    required this.text,
    this.startSize = 14,
    this.endSize = 18,
    this.startColor = Colors.white,
    this.endColor = Colors.yellowAccent,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  bool _isLarge = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          _isLarge = !_isLarge;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: widget.duration,
      tween: Tween<double>(
          begin: widget.startSize, end: _isLarge ? widget.endSize : widget.startSize),
      builder: (context, double size, child) {
        return TweenAnimationBuilder(
          duration: widget.duration,
          tween: ColorTween(
              begin: widget.startColor, end: _isLarge ? widget.endColor : widget.startColor),
          builder: (context, Color? color, child) {
            return Text(
              widget.text,
              style: TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: color),
            );
          },
        );
      },
    );
  }
}
