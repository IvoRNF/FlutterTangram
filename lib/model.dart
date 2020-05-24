import 'package:flutter/material.dart';
import 'package:tangram/rectangle.dart';
import 'package:tangram/triangle.dart';
import 'dart:async';

class Model {
  static Map<Key, List<Widget>> _keys = Map();


  static StreamController<Key> _changeSelection = StreamController.broadcast();

  static StreamController<void> _reset = StreamController.broadcast();

  static StreamController<void> _rotate = StreamController.broadcast();

  static StreamController<bool> _sucess = StreamController<bool>();

  static Sink<bool> get doSucess => _sucess.sink;
  static Stream<bool> get onSucess => _sucess.stream;
  
  static Sink<void> get doRotate => _rotate.sink;
  
  static Stream<void> get onRotate => _rotate.stream;

  static Sink<Key> get doChangeSelection => _changeSelection.sink;

  static  Stream<Key> get onChangeSelection => _changeSelection.stream;

  static Sink<void> get doReset => _reset.sink;

  static Stream<void> get onReset => _reset.stream;


  static add(Key a, Widget b) {
     
    if (Model.contains(b)) return;
    if (!Model._keys.keys.contains(a)) Model._keys[a] = [];

    List<Widget> list = Model._keys[a];

    if (!list.contains(b)) list.add(b);

    Model.checkCount();
  }

  static checkCount(){
    var count = 0;
    for(var k in Model._keys.keys){
        count += Model._keys[k].length;
    }
    if(count == 6){
      Model.doSucess.add(true);
    }
  }

  static containsInversedTriangle(Key k, bool rotated) {
    if (!Model._keys.keys.contains(k)) Model._keys[k] = [];
    List<Widget> list = Model._keys[k];
    if (list.length > 0) {
      Widget w = list.first;
      if (w is XTriangle) {
        if (w.rotated != rotated) {
          return true;
        }
      }
    }
    return false;
  }

  static containsOneTriangle(Key k) {
    if (!Model._keys.keys.contains(k)) Model._keys[k] = [];
    List<Widget> list = Model._keys[k];
    if (list.length > 0) {
      Widget w = list.first;
      return (w is XTriangle);
    }
    return false;
  }

  static containsTwoTriangle(Key k) {
    if (!Model._keys.keys.contains(k)) Model._keys[k] = [];
    List<Widget> list = Model._keys[k];
    if (list.length > 1) {
      Widget w = list.first;
      Widget w2 = list[1];
      return ((w is XTriangle) && (w2 is XTriangle));
    }
    return false;
  }

  static containsOneRectangle(Key k) {
    if (!Model._keys.keys.contains(k)) Model._keys[k] = [];
    List<Widget> list = Model._keys[k];
    if (list.length > 0) {
      Widget w = list.first;
      return ((w is XRectangle));
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

  static List<Widget> find(Key k) {
     if(Model._keys.keys.contains(k))
       return Model._keys[k];
     return null;  
  }

  static clear() {
    if(Model._keys.isNotEmpty)
      Model._keys.clear();
  }

  static len(Key a) {
    if (!Model._keys.keys.contains(a)) Model._keys[a] = [];

    return Model._keys[a].length;
  }
}
