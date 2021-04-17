import 'package:projetocompleto2/redux/app_reduce.dart';
import 'package:projetocompleto2/redux/app_state.dart';
import 'package:redux/redux.dart';

abstract class AppStore {
  static final appStore = Store<AppState>(
    AppReduce.reduce,
    initialState: AppState.initialState()
  );
}