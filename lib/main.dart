import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import './rectangle.dart';
import './triangle.dart';
import './observable.dart';
import './rectangle.target.dart';

void main() => runApp(TangramApp());

class TangramApp extends StatefulWidget {
  final String title = 'Tangram';

  num xwidth = 100;
  num xheight = 100;

  @override
  State<StatefulWidget> createState() {
    return _TangramApp();
  }
}

class _TangramApp extends State<TangramApp> {
  int colorIndex = 0;
  int stageIndex = 0;
  @override
  void initState() {
    super.initState();
    var obs = Observable();
    obs.subscribe('sucess', (value) {
      var xshowDialog = () {
        js.context.callMethod('alert', ['Parabéns']);
        /*setState(() {
          stageIndex++;
        });*/
        obs.notify('reset', null);
      };
      var future =
          new Future.delayed(const Duration(milliseconds: 500), xshowDialog);
      future.then((value) => null);
    });
  }

  get color {
    var colors = [
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.blueGrey
    ];
    if (colorIndex == colors.length) colorIndex = 0;
    return colors[colorIndex++];
  }

  @override
  Widget build(BuildContext context) {
    var stages = [
      Stack(
        children: [
          XRectangleTarget(
              left: 5,
              top: 25 + this.widget.xwidth,
              width: this.widget.xwidth,
              height: this.widget.xheight),
          XRectangleTarget(
              left: 105,
              top: 95 + this.widget.xwidth + 30,
              width: this.widget.xwidth,
              height: this.widget.xheight),
          XRectangleTarget(
              left: 5,
              top: 95 + this.widget.xwidth + 30,
              width: this.widget.xwidth,
              height: this.widget.xheight),
          XRectangleTarget(
              left: 105,
              top: 25 + this.widget.xwidth,
              width: this.widget.xwidth,
              height: this.widget.xheight),
          XRectangle(
            left: 5,
            top: 10,
            width: this.widget.xwidth,
            height: this.widget.xheight,
            color: color,
          ),
          XRectangle(
              left: 115,
              top: 10,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 10,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 115,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 215,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 315,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
        ],
      )
    , Stack(
        children: [
          XRectangleTarget(
              left: 5,
              top: 25 + this.widget.xwidth,
              width: 50,
              height: 50),
          XRectangleTarget(
              left: 5,
              top: 95 + this.widget.xwidth + 30,
              width: 50,
              height: 50),
          XRectangleTarget(
              left: 105,
              top: 25 + this.widget.xwidth,
              width: this.widget.xwidth,
              height: this.widget.xheight),
          XRectangle(
            left: 5,
            top: 10,
            width: 50,
            height: 50,
            color: color,
          ),
          XRectangle(
              left: 115,
              top: 10,
              width: 50,
              height: 50,
              color: color),
          XTriangle(
              left: 225,
              top: 10,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 115,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 215,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
          XTriangle(
              left: 225,
              top: 315,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color),
        ],
      )
    
    
    ];

    return MaterialApp(
      title: this.widget.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  var obs = Observable();
                  obs.notify('reset', null);
                })
          ],
          title: Text(this.widget.title),
        ),
        body: stages[stageIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var obs = Observable();
            obs.notify('rotate', null);
          },
          child: Icon(Icons.rotate_right),
        ),
      ),
    );
  }
}
