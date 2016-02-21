import 'dart:async' show StreamController;
import 'dart:html' show query, Event, InputElement;


abstract class _CellFormatter {
  _CellFormatter nextHandler;

  void call(Event e) {
    if (!_isCell(e)) return;
    if (_handleRequest(e)) return;
    if (nextHandler == null) return;

    nextHandler(e);
  }

  // Subclasses handle requests as needed
  bool _handleRequest(Event e) => false;

  bool _isCell(Event e) {
    var input = e.target;
    if (input is! InputElement) return false;
    if (input.type != 'text') return false;
    return true;
  }
}

class CellFormatter {
  var first;

  var _numberFormat = new NumberFormatter();
  var _dateFormat = new DateFormatter();
  var _textFormat = new TextFormatter();

  CellFormatter() {
    _numberFormat.nextHandler = _dateFormat;
    _dateFormat.nextHandler = _textFormat;
    first = _numberFormat;
  }

  void call(Event e) { first(e); }

  void ignore(String format) {
    if (format == 'number') first = _dateFormat;
  }
  void obey(String format) {
    if (format == 'number') first = _numberFormat;
  }
}

class NumberFormatter extends _CellFormatter {
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

class DateFormatter extends _CellFormatter {
  bool _handleRequest(Event e) {
    var input = e.target;
    RegExp exp = new RegExp(r"^\s*[\d/-]+\s*$");
    if (!exp.hasMatch(input.value)) return false;

    var val = DateTime.parse(input.value);
    input.value = val.toString().replaceFirst(' 00:00:00.000', '');
    return true;
  }
}

class TextFormatter extends _CellFormatter {
  bool _handleRequest(Event e) {
    var input = e.target;
    input.style.textAlign = 'left';
    return true;
  }
}

main() {
  var container = query('.container');
  var cellFormat = new CellFormatter();

  var c = new StreamController.broadcast();
  container.onChange.listen(c.add);
  container.onClick.listen(c.add);
  c.stream.listen(cellFormat);

  query('#no-numbers').onChange.listen((e){
    var el = e.target;
    if (el.checked) {
      cellFormat.ignore('number');
    }
    else {
      cellFormat.obey('number');
    }
  });
}
