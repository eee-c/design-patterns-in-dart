import 'dart:async' show Completer;
import 'dart:html' show WebSocket, document, query;

import 'package:proxy_code/web_car.dart';

main() async {
  var socket = new WebSocket('ws://localhost:4040/ws');

  var _c = new Completer();
  socket.onOpen.listen((_){ _c.complete(); });
  await _c.future;

  // Create proxy car with send/receive streams
  ProxyCar car = new ProxyCar(socket);

  document.query('#drive').onClick.listen((_) async {
    print('Drive');
    await car.drive();
    updateState(car.state);
  });

  document.query('#stop').onClick.listen((_) async {
    print('Stop');
    await car.stop();
    updateState(car.state);
  });

  updateState(car.state);
}

updateState(state) {
  state ??= 'warming up';
  query('#state').innerHtml = "Real car is $state.";
}
