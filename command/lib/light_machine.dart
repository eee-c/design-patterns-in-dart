library light_machine;

// Invoker
class Switch {
  List<Command> _history = [];

  void storeAndExecute(Command c) {
    c.execute();
    _history.add(c);
  }

  void undo() {
    _history.
      reversed.
      forEach((c) { c.execute(); });
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
