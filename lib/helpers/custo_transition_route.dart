import 'package:flutter/material.dart';

enum TranstionType {
  none,
  size,
  scale,
  fade,
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
  customTest
}

class CustomTransitionRoute<T> extends PageRouteBuilder<T> {
  final TranstionType transtionType;
  final Duration duration;
  final Widget widget;
  final Curve curve;
  final Curve reverseCurve;

  CustomTransitionRoute(
      {required this.transtionType,
      this.duration = const Duration(milliseconds: 500),
      required this.widget,
      this.curve = Curves.easeInExpo,
      this.reverseCurve = Curves.easeInBack})
      : super(
          pageBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary) {
            return widget;
          },
          transitionsBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary, Widget child) {
            
            switch (transtionType) {
              case TranstionType.size:
                return Align(
                    alignment: Alignment.topRight,
                    child: SizeTransition(sizeFactor: animation, child: child));
              case TranstionType.scale:
                return ScaleTransition(scale: animation, child: child);
              case TranstionType.fade:
                return FadeTransition(opacity: animation, child: child);
              case TranstionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              case TranstionType.slideDown:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, -1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              case TranstionType.slideLeft:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              case TranstionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              case TranstionType.customTest:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(0, 1.0),
                    ).animate(animationSecondary),
                    child: child,
                  ),
                );
              default: // TranstionType.none
                return child;
            }
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
        );
}

class CustomSizeTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  final int duration;

  CustomSizeTransitionRoute(this.widget, this.duration)
      : super(
          pageBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary) {
            return widget;
          },
          transitionsBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary, Widget child) {
            return Align(
                alignment: Alignment.topRight,
                child: SizeTransition(sizeFactor: animation, child: child));
          },
          transitionDuration: Duration(milliseconds: duration),
          reverseTransitionDuration: Duration(milliseconds: duration),
        );
}

class CustomScaleTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  CustomScaleTransitionRoute(this.widget)
      : super(
          pageBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary) {
            return widget;
          },
          transitionsBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary, Widget child) {
            return ScaleTransition(scale: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 500),
        );
}

class CustomFadeTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  CustomFadeTransitionRoute(this.widget)
      : super(
          pageBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary) {
            return widget;
          },
          transitionsBuilder: (_, Animation<double> animation,
              Animation<double> animationSecondary, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 500),
        );
}
