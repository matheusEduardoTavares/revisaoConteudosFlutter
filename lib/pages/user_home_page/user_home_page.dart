import 'package:flutter/material.dart';
import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário logado !!'),
      ),
      drawer: CustomDrawer(
        hasLogoutButton: true,
        pages: Routes.detailsUserPage,
      ),
      body: Center(
        child: Text('Seja bem vindo'),
      ),
    );
  }
}