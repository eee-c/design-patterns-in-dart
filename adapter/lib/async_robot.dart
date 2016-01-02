library async_robot;

class Bot {
  int x=0, y=0;
  void goForward()  { y++; }
  void goBackward() { y--; }
  void goLeft()     { x--; }
  void goRight()    { x++; }
}
