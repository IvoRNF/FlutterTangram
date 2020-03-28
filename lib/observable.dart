class Observable {
  static List funcs = [];

  subscribe(String topic, Function func) {
    funcs.add([topic, func]);
  }

  notify(String topic, value) {
    for (List item in funcs) {
      Function func = item[1];
      String topic_ = item[0];
      if (topic == topic_) {
        func(value);
      }
    }
  }
}
