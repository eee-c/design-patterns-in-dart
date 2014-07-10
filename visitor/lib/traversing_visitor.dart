library visitor;

import 'inventory_non_traversing.dart';
export 'inventory_non_traversing.dart';

abstract class InventoryVisitor {
  void visitMobile(Mobile i);
  void visitTablet(Tablet i);
  void visitLaptop(Laptop i);
  void visitApp(App i);
}

class PricingVisitor extends InventoryVisitor {
  double _totalPrice = 0.00;

  double get totalPrice => _totalPrice;

  void visitInventoryCollection(i) {
    _iterate(i.stuff);
  }
  void visitMobile(i) {
    _iterate(i.apps);
    _totalPrice += i.netPrice;
  }
  void visitTablet(i) {
    _iterate(i.apps);
    _totalPrice += i.discountPrice();
  }
  void visitLaptop(i) {
    _totalPrice += i.discountPrice();
  }
  void visitApp(i) {
    _totalPrice += 0.5 * i.discountPrice();
  }

  void _iterate(list) {
    list.forEach((i){ i.accept(this); });
  }
}
