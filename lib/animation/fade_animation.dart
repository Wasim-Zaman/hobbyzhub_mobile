import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateX }

enum MotionDirection { leftToRight, rightToLeft }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final MotionDirection direction;

  const FadeAnimation({
    Key? key,
    required this.delay,
    required this.child,
    this.direction = MotionDirection.leftToRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(
        AniProps.translateX,
        (direction == MotionDirection.leftToRight ? 30.0 : -30.0).tweenTo(0.0),
        500.milliseconds,
        Curves.easeOut,
      );

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) {
        return Opacity(
          opacity: value.get(AniProps.opacity),
          child: Transform.translate(
            offset: Offset(value.get(AniProps.translateX), 0),
            child: child,
          ),
        );
      },
    );
  }
}
