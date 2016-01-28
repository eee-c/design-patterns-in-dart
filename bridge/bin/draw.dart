#!/usr/bin/env dart

// Concrete Implementor
class DrawingApi1 {
  void drawCircle(double x, double y, double radius) {
    print(
      "[DrawingApi] "
      "circle at ($x, $y) with "
      "radius ${radius.toStringAsFixed(3)}"
    );
  }
}

// Abstraction
abstract class Shape {
  DrawingApi1 _drawingApi = new DrawingApi1();

  void draw();                         // low-level
  void resizeByPercentage(double pct); // high-level
}

// Refined Abstraction
class Circle extends Shape {
  double _x, _y, _radius;
  Circle(this._x, this._y, this._radius);

  // low-level i.e. Implementation specific
  void draw() {
    _drawingApi.drawCircle(_x, _y, _radius);
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
