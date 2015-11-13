library flyweight_tree;

class Tree {
  int count=0;
  var lamp_factory;

  Tree(){ lamp_factory = new LampFactory(); }

  void hang_lamp(color, branch_number) {
    new TreeBranch(branch_number)
      ..hang(lamp_factory.find_lamp(color));

    count++;
  }

  String get report => "Added ${count} lamps.\n"
    "Used ${lamp_factory.total_number_of_lamps_made} kinds of lamps.";
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
  Lamp find_lamp(color) {
    return cache.putIfAbsent(color, () => new Lamp(color));
  }
  int get total_number_of_lamps_made => cache.length;
}

class Lamp {
  String color;
  Lamp(this.color);
}
