import 'package:flutter/material.dart';
import 'package:projetocompleto2/models/transitions_page.dart';
import 'package:projetocompleto2/pages/home_page/home_page.dart';
import 'package:projetocompleto2/providers/user_provider/user_provider.dart';
import 'package:projetocompleto2/utils/db_util.dart';
import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';
import 'package:projetocompleto2/widgets/opacity_request/opacity_request.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var _showPassword = false;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          PopupMenuButton(
            onSelected: (value) => setState(() { _showPassword = value; }),
            itemBuilder: (ctx) => [
              CheckedPopupMenuItem(
                child: Text('Mostrar senha'),
                checked: _showPassword,
                value: !_showPassword,
              ),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(
        hasLogoutButton: true,
        pages: Routes.detailsUserPage,
      ),
      body: OpacityRequest(
        isLoading: _isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text('Seja bem vindo, ${user.name} !!', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            if (_showPassword ?? false)
              Text('Senha: ${user.password}', style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
            const SizedBox(height: 10),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                final isConfirmDelete = await showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: '${DateTime.now()}-${this?.hashCode}',
                  context: context,
                  pageBuilder: (ctx, _, __) => AlertDialog(
                    title: Text('Confirmação'),
                    content: Text('Deseja deletar esta conta ?'),
                    actions: [
                      TextButton(
                        child: Text('CANCELAR'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('EXCLUIR'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                );

                ///Return Early Pattern
                if (isConfirmDelete == null || !isConfirmDelete) {
                  return;
                }

                setState(() {
                  _isLoading = true;
                });

                await DbUtil.deleteByUserId(
                  user.id,
                );

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pushReplacementNamed(
                  Routes.homePage,
                  arguments: TransitionsPage(
                    builder: (ctx) => HomePage(false),
                  )
                );
              }, 
              child: Text('Deletar conta')
            ),
          ],
        ),
      ),
    );
  }
}