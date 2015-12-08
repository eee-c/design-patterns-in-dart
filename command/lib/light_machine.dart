library light_machine;

// Invoker
class Switch {
  List<Function> _history = [];

  // void storeAndExecute(Command c) {
  void storeAndExecute(Function c) {
    c.call();
    _history.add(c);
  }

  void undo() {
    _history.
      reversed.
      forEach((c) { c.call(); });
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
  void execute();
}

// Concrete Command
class OnCommand implements Command {
  Light light;
  OnCommand(this.light);
  void execute() { light.turn('ON'); }
}

// Concrete Command
class OffCommand implements Command {
  Light light;
  OffCommand(this.light);
  void execute() { light.turn('OFF'); }
}
