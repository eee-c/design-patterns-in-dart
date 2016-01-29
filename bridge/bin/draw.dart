#!/usr/bin/env dart

// Implementor
abstract class DrawingApi {
  void drawCircle(double x, double y, double radius);
}

// Concrete Implementor 1
class DrawingApi1 implements DrawingApi {
  void drawCircle(double x, double y, double radius) {
    print(
      "[DrawingApi1] "
      "circle at ($x, $y) with "
      "radius ${radius.toStringAsFixed(3)}"
    );
  }
}

// Concrete Implementor 2
class DrawingApi2 implements DrawingApi {
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
  void draw();                         // low-level
  void resizeByPercentage(double pct); // high-level
}

// Refined Abstraction
class Circle extends Shape with DrawingApi1 {
  double _x, _y, _radius;
  Circle(this._x, this._y, this._radius);

  // low-level i.e. Implementation specific
  void draw() {
    drawCircle(_x, _y, _radius);
  }
  // high-level i.e. Abstraction specific
  void resizeByPercentage(double pct) {
    _radius *= (1.0 + pct/100.0);
  }
}

// Client
main() {
  List<Shape> shapes = [
    new Circle(1.0, 2.0, 3.0),
    new Circle(5.0, 7.0, 11.0)
  ];

  shapes.forEach((shape){
    shape.resizeByPercentage(2.5);
    shape.draw();
  });
}
