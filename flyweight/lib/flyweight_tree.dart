library flyweight_tree;

class Tree {
  int count = 0;

  void hangLamp(color, branchNumber) {
    new TreeBranch(branchNumber)
      ..hang(new Lamp(color));

    count++;
  }

  String get report => "Added ${count} lamps.\n"
      "Used ${Lamp.totalCount} kinds of lamps.\n"
      "On ${TreeBranch.totalCount} branches.";
}

class TreeBranch {
  static Map _cache = {};
  static int get totalCount => _cache.length;

  factory TreeBranch(number) =>
      _cache.putIfAbsent(number, () => new TreeBranch._(number));

  int number;
  TreeBranch._(this.number);

  void hang(lamp) {
    print("  Hangs ${lamp.color} on branch #${number}.");
  }
}

class Lamp {
  static Map _cache = {};
  static int get totalCount => _cache.length;

  factory Lamp(color) =>
      _cache.putIfAbsent(color, () => new Lamp._(color));

  String color;
  Lamp._(this.color);
}
