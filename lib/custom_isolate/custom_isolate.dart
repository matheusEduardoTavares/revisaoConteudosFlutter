import 'dart:isolate';

class CustomIsolate {
  final externalPort = ReceivePort();

  void incrementCounter(int value) => _createInternalIsolate(value, true);
  void decrementCounter(int value) => _createInternalIsolate(value, false);

  Future<void> _createInternalIsolate(int value, bool isIncrement) async {
    final internalPort = ReceivePort();

    await Isolate.spawn(_logicIsolate, internalPort.sendPort);
    final isolateFromLogicIsolate = await internalPort.first;

    isolateFromLogicIsolate.send(
      IsolateSend(
        externalPort.sendPort,
        Data(
          value, 
          isIncrement
        ),
      ),
    );
  }

  static void _logicIsolate(SendPort port) {
    final otherPort = ReceivePort();

    port.send(otherPort.sendPort);

    otherPort.listen((data) {
      final IsolateSend isolateSend = data;
      final myData = isolateSend.data;

      final value = myData.value;
      final isIncrement = myData.isIncrement;
      final portToFront = isolateSend.port;

      final newValue = isIncrement ? value + 1 : value - 1;

      portToFront.send(newValue);
    });
  }
}

class IsolateSend {
  IsolateSend(
    this.port,
    this.data,
  );

  SendPort port;
  Data data;
}

class Data {
  const Data(
    this.value,
    this.isIncrement,
  );

  final int value;
  final bool isIncrement;
}