library factory_method_map;

typedef Product productFactory();
Map<Type, productFactory> Factory = {
  ConcreteCreator: (){ return new ConcreteProduct(); }
};

abstract class Creator {
  productFactory get productMaker=> Factory[this.runtimeType];
}

abstract class Product {}

class ConcreteCreator extends Creator {}

class ConcreteProduct extends Product {}
