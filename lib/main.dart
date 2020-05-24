import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import './rectangle.dart';
import './triangle.dart';
import './rectangle.target.dart';
import './model.dart';

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
  @override
  void initState() {
    super.initState();
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
                  Model.doReset.add(null);
                })
          ],
          title: Text(this.widget.title),
        ),
        body: Stack(children: [
          stages[0],
          StreamBuilder(
              stream: Model.onSucess,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data) {
                  var dlg = AlertDialog(
                      title: Text("Sucesso"),
                      content: SizedBox(
                          height: 100,
                          width: 200,
                          child: Row(children: [
                            IconButton(
                                iconSize: 40,
                                icon: Icon(Icons.done, color: Colors.green),
                                onPressed: null),
                            Text("Parabéns")
                          ])),
                      actions: <Widget>[
                        RaisedButton(
                            child: Text("OK"),
                            onPressed: () {
                              Model.doSucess.add(false);
                              Model.doReset.add(null);
                            })
                      ]);

                  return dlg;
                }
                return Container();
              })
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Model.doRotate.add(null);
          },
          child: Icon(Icons.rotate_right),
        ),
      ),
    );
  }
}
