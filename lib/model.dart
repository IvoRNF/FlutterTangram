import 'package:flutter/material.dart';
import 'package:tangram/rectangle.dart';
import 'package:tangram/triangle.dart';

class Model {
  static Map<Key, List<Widget>> _keys = Map();

  static add(Key a, Widget b) {
    if (Model.contains(b)) return;
    if (!Model._keys.keys.contains(a)) Model._keys[a] = [];

    List<Widget> list = Model._keys[a];

    if (!list.contains(b)) list.add(b);
  }

  static containsInversedTriangle(Key k, bool rotated) {
    if (!Model._keys.keys.contains(k)) Model._keys[k] = [];
    List<Widget> list = Model._keys[k];
    if (list.length > 0) {
      Widget w = list[0];
      if (w is XTriangle) {
        if (w.rotated != rotated) {
          return true;
        }
      }
    }
    return false;
  }

  static contains(Widget k) {
    for (var key in Model._keys.keys) {
      List<Widget> list = Model._keys[key];
      if (list.contains(k)) return true;
    }
    return false;
  }

  static clear() {
    Model._keys.clear();
  }

  static len(Key a) {
    if (!Model._keys.keys.contains(a)) Model._keys[a] = [];

    return Model._keys[a].length;
  }
}
