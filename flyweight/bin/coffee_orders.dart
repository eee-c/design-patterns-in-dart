#!/usr/bin/env dart

import 'package:flyweight_code/coffee_shop.dart';

/// extra-dry
// soy
// Venti Mocha Vanilla Frappuccino  hold the whip
// extra shot
// extra foam
// Triple, Venti, Soy, No Foam Latte
// Triple, Venti, Half Sweet, Non-Fat, Caramel Macchiato
// Tall, Half-Caff, Soy Latte At 120 Degrees
// Caramel Macchiato, Venti, Skim, Extra Shot, Extra-Hot, Extra-Whip, Sugar-Free
// Tall Nonfat Latte, 2 Percent Foam

// CoffeeShop.takeOrder("Frappe", 1)
// CoffeeShop.takeOrder("Espresso", 1)
// CoffeeShop.takeOrder("Frappe", 897)
// CoffeeShop.takeOrder("Cappuccino", 97)
// CoffeeShop.takeOrder("Frappe", 3)
// CoffeeShop.takeOrder("Espresso", 3)
// CoffeeShop.takeOrder("Cappuccino", 3)
// CoffeeShop.takeOrder("Espresso", 96)
// CoffeeShop.takeOrder("Frappe", 552)
// CoffeeShop.takeOrder("Cappuccino", 121)
// CoffeeShop.takeOrder("Espresso", 121)

class Mochachino implements CoffeeFlavor {
  String get name => "Mochachino";
  double get profitPerOunce => 0.3;
}

main() {
  // print(CoffeeFlavor.registered);

  var shop = new CoffeeShop()
    ..order('Cappuccino', 'large', who: 'Fred', fooFoo: 'Extra Shot')
    ..order('Espresso',   'small', who: 'Bob')
    ..order('Frappe',     'large', who: 'Alice')
    ..order('Frappe',     'large', who: 'Elsa', fooFoo: '2 Percent Foam')
    ..order('Coffee',     'small')
    ..order('Coffee',     'medium', who: 'Chris')
    ..order('Mochachino', 'large', who: 'Joy');

  // print(CoffeeFlavor.registered);
  shop.serve();
  print('-----');
  print(shop.report);
}
