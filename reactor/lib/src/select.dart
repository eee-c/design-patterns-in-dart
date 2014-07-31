part of reactor;

class Select {
  ReceivePort _in;

  static final Select _select = new Select._internal();
  factory Select()=> _select;
  Select._internal() {
    _in = new ReceivePort();
    _in.listen((m) {
      add(new MessageEvent(m['type'], m['value']));
    });
  }

  SendPort get connection => _in.sendPort;

  Queue<MessageEvent> queue = new Queue();

  void add(MessageEvent e) { queue.addLast(e); }
  MessageEvent fetch() {
    if (queue.isEmpty) return null;
    return queue.removeFirst();
  }
}

select()=> new Select().fetch();
connection()=> new Select().connection;

class MessageEvent {
  String type;
  Object value;
  MessageEvent(this.type, [this.value]);
}
