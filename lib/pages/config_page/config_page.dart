import 'package:flutter/material.dart';
import 'package:projetocompleto2/providers/configs/configs.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatelessWidget {
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
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Usar Tema "Dark":'),
              Switch(
                value: isDarkTheme,
                onChanged: (value) {
                  provider.changeTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}