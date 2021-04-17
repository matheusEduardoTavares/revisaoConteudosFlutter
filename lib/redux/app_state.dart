class AppState {
  final int counter;
  final String message;

  AppState({
    this.counter,
    this.message
  });

  factory AppState.initialState() {
    return AppState(
      counter: 0,
      message: 'Pode Entrar!',
    );
  }

  AppState copyWith({int counter, String message}) {
    return AppState(
      counter: counter ?? this.counter,
      message: message ?? this.message,
    );
  }
}