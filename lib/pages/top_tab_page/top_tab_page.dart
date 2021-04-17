import 'package:flutter/material.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class TopTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TopTab'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('teste')
      )
    );
  }
}