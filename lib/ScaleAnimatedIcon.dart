import 'package:flutter/cupertino.dart';

class ScaleAnimatedIcon extends StatefulWidget {
  final Widget icon;

  ScaleAnimatedIcon({Key key, this.icon}) : super(key: key);

  @override
  _ScaleAnimatedIconState createState() => _ScaleAnimatedIconState();
}

class _ScaleAnimatedIconState extends State<ScaleAnimatedIcon>
    with TickerProviderStateMixin {
  Tween<double> _tween = Tween(begin: 0.7, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: widget.icon,
      duration: Duration(seconds: 1),
      tween: _tween,
      curve: Curves.bounceOut,
      builder: (BuildContext context, double scale, Widget child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
    );
  }
}
