import 'dart:html';
import 'dart:math' show Random;

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_input.dart';

abstract class FormBuilder {
  Element container;
  FormBuilder(this.container);
  void addInput() {
    var input = _labelFor(inputElement);
    container.append(input);
  }
  HtmlElement get inputElement;
  _labelFor(el) {
    var text = (el is InputElement) ? el.type : el.toString();
    var label = new LabelElement()
      ..appendText("$text: ")
      ..append(el);

    return new ParagraphElement()..append(label);
  }
}

class RandomBuilder extends FormBuilder {
  RandomBuilder(el): super(el);
  Element get inputElement {
    var rand = new Random().nextInt(7);

    if (rand == 0) return new WeekInputElement();
    if (rand == 1) return new NumberInputElement();
    if (rand == 2) return new TelephoneInputElement();
    if (rand == 3) return new UrlInputElement();
    if (rand == 4) return new TimeInputElement();
    if (rand == 5) return new PaperInput();

    return new TextInputElement();
  }
}

main() async {
  await initPolymer();

  var container = query('#inputs');

  var button = new ButtonElement()
    ..appendText('Build Input')
    ..className = 'btn btn-success'
    ..onClick.listen((_){ new RandomBuilder(container).addInput(); });

  container.append(button);
}
