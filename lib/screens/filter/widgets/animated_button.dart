import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {

  final ScrollController scrollController;
  final VoidCallback onTap;

  AnimatedButton({this.scrollController, this.onTap});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<EdgeInsets> _edgeAnimation;
  Animation<double> _radiusAnimation;

  ScrollController get scrollController => widget.scrollController;
  VoidCallback get onTap => widget.onTap;

  void positionChanged() {
    if(scrollController.offset > 0.98 * scrollController.position.maxScrollExtent) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _edgeAnimation = EdgeInsetsTween(
      begin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      end: EdgeInsets.zero,
    ).animate(_controller);

    _radiusAnimation = Tween<double>(
      begin: 25,
      end: 0
    ).animate(_controller);

    scrollController.addListener(positionChanged);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 50,
            margin: _edgeAnimation.value,
            child: RaisedButton(
              color: Colors.pink,
              child: const Text(
                'Filtrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_radiusAnimation.value),
              ),
              onPressed: onTap,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    scrollController.removeListener(positionChanged);

    super.dispose();
  }
}
