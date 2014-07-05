library visitor;

import 'equipment.dart';

abstract class EquipmentVisitor {
  void visitMobile(Mobile m);
  void visitTablet(Tablet t);
  void visitLaptop(Laptop l);
}

class PricingVisitor extends EquipmentVisitor {
  double _totalPrice = 0.00;

  double get totalPrice => _totalPrice;

  void visitMobile(e) { _totalPrice += e.netPrice; }
  void visitTablet(e) { _totalPrice += e.discountPrice(); }
  void visitLaptop(e) { _totalPrice += e.discountPrice(); }
}
