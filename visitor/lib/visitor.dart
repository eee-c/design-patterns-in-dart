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

class TypeCountVisitor extends InventoryVisitor {
  Map<String,int> _count = {
    'mobile': 0,
    'tablet': 0,
    'laptop': 0,
    'app': 0
  };

  int get mobiles => _count['mobile'];
  void visitMobile(i) { _count['mobile']++; }

  int get tablets => _count['tablet'];
  void visitTablet(i) { _count['tablet']++; }

  int get laptops => _count['laptop'];
  void visitLaptop(i) { _count['laptop']++; }

  int get apps => _count['app'];
  void visitApp(i) { _count['app']++; }
}
