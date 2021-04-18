import 'package:flutter/material.dart';
import 'package:projetocompleto2/models/transitions_page.dart';
import 'package:projetocompleto2/pages/user_home_page/user_home_page.dart';
import 'package:projetocompleto2/providers/configs/configs.dart';
import 'package:projetocompleto2/providers/user_provider/user_provider.dart';
import 'package:projetocompleto2/utils/db_util.dart';
import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage([this.hasVerifyUser = true]);

  final bool hasVerifyUser;

  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var _currentAppState = 'Sem informações';
  var _isLoading = true;

  @override 
  void initState() {
    super.initState();

    if (widget.hasVerifyUser ?? true) {
      DbUtil.getData().then((user) {
        if (user != null) {
          final indexUserLogged = user.indexWhere((user) => user.isLogged);

          if (indexUserLogged != -1) {
            final userLogged = user[indexUserLogged];

            Provider.of<UserProvider>(context, listen: false).updateUser(userLogged);
            Provider.of<Configs>(context, listen: false).updateConfig(userLogged.isDarkTheme);

            Navigator.of(context).pushReplacementNamed(
              Routes.userHomePage,
              arguments: TransitionsPage(
                isUserPage: true,
                builder: (ctx) => UserHomePage()
              )
            );
          }
        }

        setState(() {
          _isLoading = false;
        });
      });
    }
    else {
      setState(() {
        _isLoading = false;
      });
    }

    WidgetsBinding.instance.addObserver(this);
  }

  @override 
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final stateInText = state.toString();

    setState(() {
      _currentAppState = stateInText.substring(stateInText.indexOf('.') + 1);
    });
  }

  @override 
  Widget build(BuildContext context) {
    return !_isLoading ? Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text(_currentAppState, style: TextStyle(fontSize: 40, color: Colors.red))
      ),
    ) : Center(
      child: CircularProgressIndicator(),
    );
  }

  @override 
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}