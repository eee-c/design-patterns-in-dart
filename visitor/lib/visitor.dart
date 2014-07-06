library visitor;

import 'inventory.dart';

abstract class InventoryVisitor {
  void visitMobile(Mobile i);
  void visitTablet(Tablet i);
  void visitLaptop(Laptop i);
  void visitApp(App i);
}

class PricingVisitor extends InventoryVisitor {
  double _totalPrice = 0.00;

  double get totalPrice => _totalPrice;

  void visitMobile(i) { _totalPrice += i.netPrice; }
  void visitTablet(i) { _totalPrice += i.discountPrice(); }
  void visitLaptop(i) { _totalPrice += i.discountPrice(); }

  void visitApp(i) { _totalPrice += 0.5 * i.discountPrice(); }
}
