import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink; // Data Input
  Stream<int> get counter => _counterStateController.stream; // Data Output

  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink =>
      _counterEventController.sink; // Data Input

  CounterBloc() {
    // Whenever there's a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    event is IncrementEvent ? _counter++ : _counter > 0 ? _counter-- : 0;
    _inCounter.add(_counter);
  }

  void dispose(){
    _counterEventController.close();
    _counterStateController.close();
  }
}

