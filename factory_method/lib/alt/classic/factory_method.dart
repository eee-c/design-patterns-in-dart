library factory_method_subclass;

abstract class Creator {
  Product productMaker();
}

abstract class Product {}

class ConcreteCreator extends Creator {
  productMaker()=> new ConcreteProduct();
}

class ConcreteProduct extends Product {}
