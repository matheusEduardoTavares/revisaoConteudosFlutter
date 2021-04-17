import 'package:flutter/material.dart';
import 'package:projetocompleto2/models/transitions_page.dart';
import 'package:projetocompleto2/pages/home_page/home_page.dart';
import 'package:projetocompleto2/utils/routes.dart';

class PositionedButtonToHomePage extends StatelessWidget {
  const PositionedButtonToHomePage({
    this.left,
    this.top,
    this.child,
    this.arguments
  });

  final double left;
  final double top;
  final Widget child;
  final Object arguments;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left ?? 16,
      top: top ?? 16,
      child: child ?? FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () async {
          final backToPages = await showGeneralDialog(
            context: context,
            transitionDuration: const Duration(seconds: 1),
            barrierDismissible: true,
            barrierLabel: '',
            pageBuilder: (ctx, animation, _) => FadeTransition(
              opacity: animation,
              child: AlertDialog(
                title: Text('Voltar para a Home'),
                content: Text('Deseja realmente voltar para a HomePage ?'),
                actions: [
                  TextButton(
                    child: Text('NÃO'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: Text('SIM'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ),
          );

          if (backToPages != null && backToPages) {
            Navigator.of(context).pushReplacementNamed(
              Routes.homePage,
              arguments: TransitionsPage(
                builder: (ctx) => HomePage(),
                arguments: arguments,
              ),
            );
          }
        },
      ),
    );
  }
}