import 'package:flutter/material.dart';

class CustomMaterialPageRoute extends MaterialPageRoute {
  CustomMaterialPageRoute({
    @required this.builder,
    this.settings,
    this.fullscreenDialog = false,
    this.hasAnimation = true,
    this.maintainState = true,
  }) : super(
    builder: builder,
    fullscreenDialog: fullscreenDialog,
    maintainState: maintainState,
    settings: settings,
  );

  final RouteSettings settings;
  final bool fullscreenDialog;
  final bool maintainState;
  final WidgetBuilder builder;
  final bool hasAnimation;

  @override 
  Widget buildTransitions(
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child,
  ){
    if (hasAnimation) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }

    return child;
  }
}