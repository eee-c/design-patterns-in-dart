#!/usr/bin/env dart

// Implementor
abstract class DrawingApi {
  int _refCount = 0;
  void ref() {
    _refCount++;
    print('  $this Increased refcount to $_refCount');
  }
  void deref() {
    _refCount--;
    print('  $this Decreased refcount to $_refCount');
  }
  void drawCircle(double x, double y, double radius);
}

// Concrete Implementor 1
class DrawingApi1 extends DrawingApi {
  void drawCircle(double x, double y, double radius) {
    print(
      "[DrawingApi1] "
      "circle at ($x, $y) with "
      "radius ${radius.toStringAsFixed(3)}"
    );
  }
}

// Concrete Implementor 2
class DrawingApi2 extends DrawingApi {
  void drawCircle(double x, double y, double radius) {
    print(
      "[DrawingApi2] "
      "circle at ($x, $y) with "
      "radius ${radius.toStringAsFixed(3)}"
    );
  }
}

// Abstraction

abstract class Shape {
  DrawingApi _drawingApi;

  set drawer(DrawingApi other) {
    other.ref();
    if (_drawingApi != null) {
      _drawingApi.deref();
      if (_drawingApi._refCount == 0) {
        print('  ** Deleting no longer used $_drawingApi **');
        _drawingApi = null;
      }
    }
    _drawingApi = other;
  }

  void resizeByPercentage(double pct); // high-level
}

// Refined Abstraction
class Circle extends Shape {
  double _x, _y, _radius;
  Circle(this._x, this._y, this._radius);

  // low-level i.e. Implementation specific
  void draw() {
    if (_drawingApi == null) return;
    _drawingApi.drawCircle(_x, _y, _radius);
  }
  // high-level i.e. Abstraction specific
  void resizeByPercentage(double pct) {
    _radius *= (1.0 + pct/100.0);
  }
}

// Client
main() {
  var api1 = new DrawingApi1(),
      api2 = new DrawingApi2();

  var circle1 = new Circle(1.0, 2.0, 3.0)..drawer = api1,
      circle2 = new Circle(0.0, 6.0, 1.0)..drawer = api1,
      circle3 = new Circle(2.0, 2.0, 1.5)..drawer = api2;

  circle1.draw();
  circle2.draw();
  circle3.draw();

  circle1.drawer = api2;
  circle2.drawer = api2;

  api1 = api2 = null;

  circle1.draw();
  circle2.draw();
  circle3.draw();
}
