class Observable {
  static List _funcs = [];

  subscribe(String topic, Function func) {
    var item = Map();
    item[topic] = func;
    _funcs.add(item);
  }

  notify(String topic, value) {
    for (Map item in _funcs) {
      if (item.containsKey(topic)) {
        Function func = item[topic];
        func(value);
      }
    }
  }
}
