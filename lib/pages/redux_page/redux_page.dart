import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:projetocompleto2/pages/redux_page/home_redux/home_redux.dart';
import 'package:projetocompleto2/redux/app_store.dart';

class ReduxPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return StoreProvider(
      store: AppStore.appStore,
      child: HomeRedux()
    );
  }
}