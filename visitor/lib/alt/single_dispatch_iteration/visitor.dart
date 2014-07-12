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

  void visitMobile(i) { totalPrice += i.netPrice; }
  void visitTablet(i) { totalPrice += i.discountPrice(); }
  void visitLaptop(i) { totalPrice += i.discountPrice(); }

  void visitApp(i) { totalPrice += 0.5 * i.discountPrice(); }
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
