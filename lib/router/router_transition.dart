import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTransitionFade<T> extends CustomTransitionPage {
  CustomTransitionFade({
    super.key,
    required super.child,
    required super.transitionDuration,
  }) : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.fastLinearToSlowEaseIn)
                  .animate(animation),
              child: child,
            );
          },
        );
}
