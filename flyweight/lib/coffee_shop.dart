library coffee_shop;

import 'package:reflectable/reflectable.dart';

class Flavor extends Reflectable {
  const Flavor()
    : super(newInstanceCapability);
}

const flavor = const Flavor();

class CoffeeShop {
  static Map sizes = {
    'small': 8,
    'medium': 12,
    'large': 20
  };

  List _orders = [];

  void order(name, sizeName, {who, fooFoo}) {
    var flavor = new CoffeeFlavor(name);
    int size = sizes[sizeName];
    _orders.add(new Order(flavor, size, who, fooFoo));
  }

  void serve() {
    _orders.forEach((o) { print("Served ${o.service}.");});
  }

  String get report => "Served ${_orders.length} coffee drinks.\n"
      "Served ${CoffeeFlavor.totalCount} kinds of coffee drinks.\n"
      "For a profit of: \$${profit}";

  double get profit {
    var sum = 0;
    _orders.forEach((o){ sum += o.profit; });
    return sum;
  }
}

class Order {
  CoffeeFlavor flavor;
  int size;
  String instructions;
  String who;

  Order(this.flavor, this.size, this.who, this.instructions);

  String get service => "${flavor.name} to ${who}";
  double get profit => size * flavor.profitPerOunce;
}

class CoffeeFlavor {
  static Map _cache = {};
  static int get totalCount => _cache.length;

  static Map classMirrors = flavor.
    annotatedClasses.
    fold({}, (memo, c) => memo..[c.simpleName]= c);


  factory CoffeeFlavor(name) {
    // print(classMirrors);
    return _cache.putIfAbsent(name, () =>
        classMirrors[name].newInstance('', []));
  }

  static get registered => _cache;

  String get name => "Fake Coffee";
  double get profitPerOunce => 0.0;
}

@flavor
class Coffee implements CoffeeFlavor {
  String get name => "Coffee";
  double get profitPerOunce => 0.05;
}

@flavor
class FlatWhite implements CoffeeFlavor {
  String get name => "Flat White";
  double get profitPerOunce => 0.25;
}

@flavor
class Cappuccino implements CoffeeFlavor {
  String get name => 'Cappuccino';
  double get profitPerOunce => 0.35;
}

@flavor
class Espresso implements CoffeeFlavor {
  String get name => 'Espresso';
  double get profitPerOunce => 0.15;
}

@flavor
class Frappe implements CoffeeFlavor {
  String get name => 'Frappe';
  double get profitPerOunce => 0.3;
}

@flavor
class Americano implements CoffeeFlavor {
  String get name => 'Americano';
  double get profitPerOunce => 0.2;
}

@flavor
class FakeCoffee implements CoffeeFlavor {
  String get name => "Fake Coffee";
  double get profitPerOunce => 0.0;
}
