library coffee_shop_test;

import 'package:test/test.dart';

import 'package:flyweight_code/coffee_shop.dart';

main(){
  var shop;

  setUp((){
    shop = new CoffeeShop()
      ..order('Cappuccino', 'large', who: 'Fred', fooFoo: 'Extra Shot')
      ..order('Espresso',   'small', who: 'Bob')
      ..order('Cappuccino',     'large', who: 'Alice');
  });

  test('it can calculate profit', (){
    expect(shop.profit, 15.2);
  });

  test('it flyweights', (){
    expect(CoffeeFlavor.totalCount, 2);
  });

  test('prints when serving', (){
    expect(shop.serve, prints(contains('Served Espresso to Bob.')));
  });
}
