import 'dart:async' show StreamController;
import 'dart:html' show query, Event, InputElement;

abstract class CellFormatter {
  CellFormatter nextHandler;

  CellFormatter([this.nextHandler]);

  void call(Event e) {
    if (!isCell(e)) return;
    if (_handleRequest(e)) return;
    if (nextHandler == null) return;

    nextHandler(e);
  }

  // Subclasses handle requests as needed
  bool _handleRequest(Event e) => false;

  bool isCell(Event e) {
    var input = e.target;
    if (input is! InputElement) return false;
    if (input.type != 'text') return false;
    return true;
  }
}

class NumberFormatter extends CellFormatter {
  NumberFormatter([nextHandler]) : super(nextHandler);

  bool _handleRequest(Event e) {
    var input = e.target;
    RegExp exp = new RegExp(r"^\s*[\d\.]+\s*$");
    if (!exp.hasMatch(input.value)) return false;

    var val = double.parse(input.value);
    input.value = val.toStringAsFixed(2);
    input.style.textAlign = 'right';
    return true;
  }
}

class DateFormatter extends CellFormatter {
  DateFormatter([nextHandler]) : super(nextHandler);

  bool _handleRequest(Event e) {
    var input = e.target;
    RegExp exp = new RegExp(r"^\s*[\d/-]+\s*$");
    if (!exp.hasMatch(input.value)) return false;

    var val = DateTime.parse(input.value);
    input.value = val.toString().replaceFirst(' 00:00:00.000', '');
    return true;
  }
}

class TextFormatter extends CellFormatter {
  TextFormatter([nextHandler]) : super(nextHandler);

  bool _handleRequest(Event e) {
    var input = e.target;
    input.style.textAlign = 'left';
    return true;
  }
}

main() {
  var container = query('.container');

  var textFormat = new TextFormatter();
  var dateFormat = new DateFormatter(textFormat);
  var numberFormat = new NumberFormatter(dateFormat);

  var c = new StreamController.broadcast();
  container.onChange.listen(c.add);
  container.onClick.listen(c.add);

  var subscription = c.stream.
    listen(numberFormat);

  query('#no-numbers').onChange.listen((e){
    var el = e.target;
    if (el.checked) {
      subscription.cancel();
      subscription = c.stream.
        listen(dateFormat);
    }
    else {
      subscription.cancel();
      subscription = c.stream.
        listen(numberFormat);
    }
  });

  query('#no-text').onChange.listen((e){
    var el = e.target;
    if (el.checked) {
      dateFormat.nextHandler = null;
    }
    else {
      dateFormat.nextHandler = textFormat;
    }
  });
}
