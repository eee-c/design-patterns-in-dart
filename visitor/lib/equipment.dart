library equipment;

abstract class Equipment {
  String name;
  Equipment(this.name);

  int watt;
  double netPrice;
  double discountPrice() => netPrice;

  void accept(vistor);
}

class Mobile extends Equipment {
  Mobile(): super('Mobile Phone');
  double netPrice = 350.00;
  void accept(visitor) { visitor.visitMobile(this); }
}

class Tablet extends Equipment {
  Tablet(): super('Tablet');
  double netPrice = 400.00;
  void accept(visitor) { visitor.visitTablet(this); }
}

class Laptop extends Equipment {
  Laptop(): super('Laptop');
  double netPrice = 1000.00;
  double discountPrice() => netPrice * .9;
  void accept(visitor) { visitor.visitLaptop(this); }
}
