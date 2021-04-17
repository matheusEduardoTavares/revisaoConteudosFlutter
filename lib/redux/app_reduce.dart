import 'package:projetocompleto2/redux/actions.dart';
import 'package:projetocompleto2/redux/app_state.dart';

abstract class AppReduce {
  static AppState reduce(AppState state, dynamic action) {
    if (action is IncrementCounter) {
      return state.copyWith(
        counter: state.counter + 1,
        message: _getMessage(state.counter + 1)
      );
    }
    else if (action is DecrementCounter) {
      return state.copyWith(
        counter: state.counter - 1,
        message: _getMessage(state.counter - 1)
      );
    }

    return state;
  }

  static String _getMessage(int newCounter) {
    if (newCounter > 10) {
      return 'Lotado';
    }
    else if (newCounter >= 0) {
      return 'Pode Entrar!';
    }

    return 'Mundo Alternativo!';
  }
}