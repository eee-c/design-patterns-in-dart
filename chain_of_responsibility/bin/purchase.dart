#!/usr/bin/env dart

abstract class PurchasePower {
  // Successor in the chain of responsibility
  PurchasePower _reportsTo;
  void set reportsTo(PurchasePower reportsTo) {
    _reportsTo = reportsTo;
  }

  void processRequest(PurchaseRequest request) {
    if (_reportsTo != null) {
      _reportsTo.processRequest(request);
    }
  }
}

class ManagerPurchasePower extends PurchasePower {
  final double _allowable = 10 * 1000.0;

  void processRequest(PurchaseRequest request) {
    if (request.amount < _allowable) {
      print("Manager will approve $request.");
      return;
    }
    super.processRequest(request);
  }
}

class DirectorPurchasePower extends PurchasePower {
  final double _allowable = 20 * 1000.0;

  void processRequest(PurchaseRequest request) {
    if (request.amount < _allowable) {
      print("Director will approve $request");
      return;
    }
    super.processRequest(request);
  }
}

class VicePresidentPurchasePower extends PurchasePower {
  final double _allowable = 40 * 1000.0;

  void processRequest(PurchaseRequest request) {
    if (request.amount < _allowable) {
      print("Vice President will approve $request");
      return;
    }
    super.processRequest(request);
  }
}

class PresidentPurchasePower extends PurchasePower {
  final double _allowable = 60 * 1000.0;

  void processRequest(PurchaseRequest request) {
    if (request.amount < _allowable) {
      print("President will approve $request");
      return;
    }
    super.processRequest(request);
  }
}

class PurchaseRequest {
  double amount;
  String purpose;
  PurchaseRequest(this.amount, this.purpose);
  String toString() =>
    "\$${amount.toStringAsFixed(2)} for $purpose";
}

main(args) {
  var manager = new ManagerPurchasePower();
  var director = new DirectorPurchasePower();
  var vp = new VicePresidentPurchasePower();
  var president = new PresidentPurchasePower();

  manager.reportsTo = director;
  director.reportsTo = vp;
  vp.reportsTo = president;

  var amount = (args[0] == null) ?
    1000 : double.parse(args[0]);

  var req = new PurchaseRequest(amount, "General Purpose Usage");
  manager.processRequest(req);
}
