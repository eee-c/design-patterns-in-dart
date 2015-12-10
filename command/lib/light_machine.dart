library light_machine;

// Invoker
class Switch {
  List<Command> _history = [];

  // void storeAndExecute(Command c) {
  void storeAndExecute(Function c) {
    c.call();
    _history.add(c);
  }

  void undo() {
    print('--');
    _history.
      reversed.
      forEach((c) { c.undo(); });
  }
}

// Receiver
class Light {
  String state = 'OFF';
  void turn(String newState) {
    state = newState;
    print("Light ${state}");
  }
}

// Abstract command
abstract class Command {
  void call();
}

class LightCommand implements Command {
  Light light;
  String _prev;
  LightCommand(this.light);
  void call() {
    _prev = light.state;
  }
  void undo() {
    light.turn(_prev);
  }
}

// Concrete Command
class OnCommand extends LightCommand {
  OnCommand(light): super(light);
  void call() {
    super.call();
    light.turn('ON');
  }
}

// Concrete Command
class OffCommand extends LightCommand {
  OffCommand(light): super(light);
  void call() {
    super.call();
    light.turn('OFF');
  }
}

// Concrete Command
class FiftyCommand extends LightCommand {
  FiftyCommand(light): super(light);
  void call() {
    super.call();
    light.turn('50%');
  }
}
