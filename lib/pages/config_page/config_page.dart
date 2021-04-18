import 'package:flutter/material.dart';
import 'package:projetocompleto2/providers/configs/configs.dart';
import 'package:projetocompleto2/providers/user_provider/user_provider.dart';
import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';
import 'package:projetocompleto2/widgets/opacity_request/opacity_request.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({
    this.isUserPage = false,
  });

  final bool isUserPage;

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  var _isUpdate = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Configs>(context);
    final brightnessTheme = provider.appBrightness;
    final isDarkTheme = brightnessTheme == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        pages: widget.isUserPage ? Routes.detailsUserPage : 
          Routes.detailsGlobalPage,
        hasLogoutButton: widget.isUserPage,
        ),
      body: OpacityRequest(
        isLoading: _isUpdate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Usar Tema "Dark"'),
                Switch(
                  value: isDarkTheme,
                  onChanged: (value) async {
                    setState(() {
                      _isUpdate = true;
                    });

                    await provider.changeTheme(
                      Provider.of<UserProvider>(context, listen: false)
                    );

                    setState(() {
                      _isUpdate = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}