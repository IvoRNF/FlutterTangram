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
  @override
  void initState() {
    
    super.initState();
    var obs = Observable();
    obs.subscribe('sucess', (value) {
      var xshowDialog = () {
        js.context.callMethod('alert',['Parabéns']);
        obs.notify('reset',null);
      };
      var future =
          new Future.delayed(const Duration(milliseconds: 500), xshowDialog);
      future.then((value) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Colors.blue;
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
        body: Stack(
          children: [
            XRectangleTarget(
                left: 5,
                top: 125 + this.widget.xwidth,
                width: this.widget.xwidth,
                height: this.widget.xheight),
            XRectangleTarget(
                left: 105,
                top: 195 + this.widget.xwidth + 30,
                width: this.widget.xwidth,
                height: this.widget.xheight),
            XRectangleTarget(
                left: 5,
                top: 195 + this.widget.xwidth + 30,
                width: this.widget.xwidth,
                height: this.widget.xheight),
            XRectangleTarget(
                left: 105,
                top: 125 + this.widget.xwidth,
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
                left: 5,
                top: 115,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
            XTriangle(
                left: 115,
                top: 115,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
            XTriangle(
                left: 215,
                top: 115,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
          ],
        ),
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
