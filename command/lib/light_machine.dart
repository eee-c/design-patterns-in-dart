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
  void turn(String state) {
    print("Light ${state}");
  }
}

// Abstract command
abstract class Command {
  void call();
}

// Concrete Command
class OnCommand implements Command {
  Light light;
  OnCommand(this.light);
  void call() { light.turn('ON'); }
  void undo() { light.turn('OFF'); }
}

// Concrete Command
class OffCommand implements Command {
  Light light;
  OffCommand(this.light);
  void call() { light.turn('OFF'); }
  void undo() { light.turn('ON'); }
}
