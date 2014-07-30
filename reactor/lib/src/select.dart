part of reactor;

class Select {
  StreamController<Map> connection;

  static final Select _select = new Select._internal();
  factory Select()=> _select;
  Select._internal() {
    connection = new StreamController();

    connection.
      stream.
      listen((m) {
        add(new MessageEvent(m['type'], m['value']));
      });
  }

  Queue<MessageEvent> queue = new Queue();

  void add(MessageEvent e) { queue.addLast(e); }
  MessageEvent fetch() {
    if (queue.isEmpty) return null;
    return queue.removeFirst();
  }
}

select()=> new Select();
connect()=> new Select().connection;

class MessageEvent {
  String type;
  Object value;
  MessageEvent(this.type, [this.value]);
}
