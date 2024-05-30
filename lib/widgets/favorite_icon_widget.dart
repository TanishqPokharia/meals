import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key, required this.color, required this.onPressed})
      : super(key: key);
  final Color color;
  final Function() onPressed;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200),
        lowerBound: 0,
        upperBound: 0.5);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController.value);
    // TODO: implement build
    return AnimatedBuilder(
        animation: _animationController,
        child: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              print(_animationController.value);
              widget.onPressed();
              _animationController
                  .forward()
                  .then((value) => _animationController.reverse());
            },
            icon: Icon(
              Icons.favorite,
              size: 15,
              color: widget.color,
            )),
        builder: (context, child) {
          return Transform.scale(
            scale: Tween<double>(begin: 2, end: 1)
                .animate(CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut))
                .value,
            child: child,
          );
        });
  }
}
