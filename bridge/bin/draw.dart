#!/usr/bin/env dart

import 'dart:mirrors' show reflectClass;

// Implementor
abstract class DrawingApi {
  void drawCircle(double x, double y, double radius);
}

// Concrete Implementor 1
class DrawingApi1 implements DrawingApi {
  static final DrawingApi1 _drawingApi = new DrawingApi1._internal();
  factory DrawingApi1()=> _drawingApi;
  DrawingApi1._internal();

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
  DrawingApi _drawingApi;
  static Map<Type, DrawingApi> _drawingApiCache = {};

  Shape(Type drawingApi) {
    _drawingApi = _drawingApiCache.putIfAbsent(
      drawingApi,
      ()=> reflectClass(drawingApi).newInstance(new Symbol(''), []).reflectee
    );
  }

  void reset() { _drawingApiCache.clear(); }

  void draw();                         // low-level
  void resizeByPercentage(double pct); // high-level
}

// Refined Abstraction
class Circle extends Shape {
  double _x, _y, _radius;
  Circle(this._x, this._y, this._radius, Type drawingApi) :
    super(drawingApi);

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
    new Circle(1.0, 2.0, 3.0, DrawingApi1),
    new Circle(0.0, 6.0, 1.0, DrawingApi1),
    new Circle(2.0, 2.0, 1.5, DrawingApi1),
    new Circle(5.0, 7.0, 11.0, DrawingApi2),
    new Circle(1.0, 2.0, 3.0, DrawingApi1),
    new Circle(5.0, -7.0, 1.0, DrawingApi2),
    new Circle(-1.0, -2.0, 5.0, DrawingApi1)
  ];

  shapes.forEach((shape){
    shape.resizeByPercentage(2.5);
    shape.draw();
  });
}
