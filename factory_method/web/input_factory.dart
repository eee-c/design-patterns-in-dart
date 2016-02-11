import 'dart:html';
import 'dart:math' show Random;

abstract class FormBuilder {
  Element container;
  FormBuilder(this.container);
  void addInput() {
    var input = _labelFor(inputElement);
    container.append(input);
  }
  InputElement get inputElement;
  _labelFor(el) {
    var label = new LabelElement()
      ..appendText("${el.type}: ")
      ..append(el);

    return new ParagraphElement()..append(label);
  }
}

class RandomBuilder extends FormBuilder {
  RandomBuilder(el): super(el);
  InputElement get inputElement {
    var rand = new Random().nextInt(6);

    if (rand == 0) return new WeekInputElement();
    if (rand == 1) return new NumberInputElement();
    if (rand == 2) return new TelephoneInputElement();
    if (rand == 3) return new UrlInputElement();
    if (rand == 4) return new TimeInputElement();

    return new TextInputElement();
  }
}

main(){
  var container = query('#inputs');

  var button = new ButtonElement()
    ..appendText('Build Input')
    ..className = 'btn btn-success'
    ..onClick.listen((_){ new RandomBuilder(container).addInput(); });

  container.append(button);
}
