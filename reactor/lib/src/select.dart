part of reactor;

class Select {
  static final Select _select = new Select._internal();
  factory Select()=> _select;
  Select._internal();

  Queue<SystemEvent> queue = new Queue();

  void add(String type) { queue.addLast(type); }
  SystemEvent fetch() {
    if (queue.isEmpty) return null;
    return queue.removeFirst();
  }
}

select()=> new Select();

class SystemEvent {
  int handleId;
  String type;
  SystemEvent(this.type, this.handleId);
}

class Handle {
  static int nextNumber = 1;
  static Map<int,Handle> lookup = {};

  int number;
  String type;
  var stream;
  Handle(this.type, this.stream){
    number = Handle.nextNumber++;
    Handle.lookup[number] = this;
  }
}
