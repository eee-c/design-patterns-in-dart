library factory_method_mirror;

// @MirrorsUsed(targets: 'ConcreteProduct')
@MirrorsUsed(metaTargets: const[FactoryProduct])
import 'dart:mirrors';

const FactoryProduct product = const FactoryProduct();
class FactoryProduct {
  const FactoryProduct();
}


abstract class Creator {
  Type productClass;
  //ClassMirror mirror;

  Product productMaker() {
    return reflectClass(productClass).
    // mirror.
      newInstance(const Symbol(''), []).
      reflectee;
  }
}

abstract class Product {}

class ConcreteCreator extends Creator {
  Type productClass = ConcreteProduct;
  // static ClassMirror _mirror = reflectClass(ConcreteProduct);
  // get mirror => _mirror;
}

@product
class ConcreteProduct extends Product {}
