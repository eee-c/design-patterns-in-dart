library visitor_setup;

var visitorMaker;
var inventoryCollectionMaker;
var mobile;
var tablet;
var laptop;
var app;

var visitor, nodes;

setup() {
  visitor = visitorMaker();

  nodes = inventoryCollectionMaker([mobile(), tablet(), laptop()]);
  for (var i=0; i<1000; i++) {
    nodes.stuff[0].apps.add(app('Mobile App $i', price: i));
  }
  for (var i=0; i<100; i++) {
    nodes.stuff[1].apps.add(app('Tablet App $i', price: i));
  }
}

run(loopSize) {
  for (var i=0; i<loopSize; i++) {
    visitor.totalPrice = 0.0;
    nodes.accept(visitor);
  }
}
