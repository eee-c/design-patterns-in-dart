#!/usr/bin/env dart

abstract class Image {
  void displayImage();
}

class RealImage implements Image {
  String _filename;

  RealImage(this._filename) {
    _loadImageFromDisk();
  }

  void _loadImageFromDisk() {
    print("Loading    $_filename");
  }

  void displayImage() {
    print("Displaying $_filename");
  }
}

final BlankImage = new RealImage("blank");

class ProxyImage implements Image {
  RealImage _image;
  String _filename;

  ProxyImage(this._filename);

  void displayImage() {
    if (_image != null) return _image.displayImage();

    print("[ProxyImage] cache miss $_filename");
    BlankImage.displayImage();
    new RealImage(_lowFilename)..displayImage();
    _image = new RealImage(_filename)..displayImage();
  }

  String get _lowFilename =>
    _filename.replaceFirst(new RegExp(r'HiRes_\d+\w+_'), 'LoRes_');
}

main() {
  Image image1 = new ProxyImage("HiRes_10MB_Photo1");
  Image image2 = new ProxyImage("HiRes_10MB_Photo2");

  image1.displayImage(); // loading necessary
  image1.displayImage(); // loading unnecessary
  image2.displayImage(); // loading necessary
  image2.displayImage(); // loading unnecessary
  image1.displayImage(); // loading unnecessary
}
