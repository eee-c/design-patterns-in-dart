part of reactor;

class Select {
  static final Select _select = new Select._internal();
  factory Select()=> _select;
  Select._internal();

  ReceivePort _from;

  static set source(ReceivePort r) {
    _select._from = r.asBroadcastStream();
    r.listen((m) {
      _select.add(new MessageEvent(m['type'], m['value']));
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

class MessageEvent {
  String type;
  Object value;
  MessageEvent(this.type, [this.value]);
}
