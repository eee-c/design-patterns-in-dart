library coffee_shop;

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

  factory CoffeeFlavor(name) =>
      _cache.putIfAbsent(name, () => new CoffeeFlavor._(name));

  String name;
  CoffeeFlavor._(this.name);
  double get profitPerOunce => name == 'Frappe' ? .5 : 0.1;
}
