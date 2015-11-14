library flyweight_tree;

class Tree {
  int count = 0;
  var _lampFactory;

  Tree() {
    _lampFactory = new LampFactory();
  }

  void hangLamp(color, branchNumber) {
    new TreeBranch(branchNumber)
      ..hang(_lampFactory.findLamp(color));

    count++;
  }

  String get report => "Added ${count} lamps.\n"
      "Used ${_lampFactory.totalNumberOfLampsMade} kinds of lamps.";
}

class TreeBranch {
  int number;

  TreeBranch(this.number);

  void hang(lamp) {
    print("  Hangs ${lamp.color} on branch #${number}.");
  }
}

class LampFactory {
  var cache = {};
  Lamp findLamp(color) {
    return cache.putIfAbsent(color, () => new Lamp(color));
  }

  int get totalNumberOfLampsMade => cache.length;
}

class Lamp {
  String color;
  Lamp(this.color);
}
