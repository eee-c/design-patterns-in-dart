#!/usr/bin/env dart

class Employee {
  String firstName, lastName;
  Employee reportsTo;

  String get title => "${this.runtimeType}";
  String toString() => title;
}

@proxy
abstract class _PurchasePower {
  final double _allowable = 0.0;

  get successor => reportsTo;

  void processRequest(PurchaseRequest request) {
    if (_processRequest(request)) return;
    if (successor == null) return;

    successor.processRequest(request);
  }

  bool _processRequest(PurchaseRequest request) {
    if (request.amount > _allowable) return false;

    print("$this will approve $request.");
    return true;
  }
}

class Manager extends Employee with _PurchasePower {
  final double _allowable = 10 * 1000.0;
}

class Director extends Employee with _PurchasePower {
  final double _allowable = 20 * 1000.0;
}

class VicePresident extends Employee with _PurchasePower {
  final double _allowable = 40 * 1000.0;
}

class President extends Employee with _PurchasePower {
  final double _allowable = 60 * 1000.0;

  void processRequest(PurchaseRequest request) {
    if (request.amount > _allowable) {
      print("Your request for $request needs a board meeting!");
    }
    else {
      print("President will approve $request");
    }
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
  var manager = new Manager();
  var director = new Director();
  var vp = new VicePresident();
  var president = new President();

  manager.reportsTo = director;
  director.reportsTo = vp;
  vp.reportsTo = president;

  var amount = (args[0] == null) ?
    1000 : double.parse(args[0]);

  var req = new PurchaseRequest(amount, "General Purpose Usage");
  manager.processRequest(req);
}
