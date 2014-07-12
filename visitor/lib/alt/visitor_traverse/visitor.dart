library visitor;

import 'inventory.dart';
export 'inventory.dart';

abstract class InventoryVisitor {
  void visitMobile(Mobile i);
  void visitTablet(Tablet i);
  void visitLaptop(Laptop i);
  void visitApp(App i);
}

class PricingVisitor extends InventoryVisitor {
  double totalPrice = 0.00;

  void visitInventoryCollection(i) {
    _iterate(i.stuff);
  }
  void visitMobile(i) {
    _iterate(i.apps);
    totalPrice += i.netPrice;
  }
  void visitTablet(i) {
    _iterate(i.apps);
    totalPrice += i.discountPrice();
  }
  void visitLaptop(i) {
    totalPrice += i.discountPrice();
  }
  void visitApp(i) {
    totalPrice += 0.5 * i.discountPrice();
  }

  void _iterate(list) {
    list.forEach((i){ i.accept(this); });
  }
}
