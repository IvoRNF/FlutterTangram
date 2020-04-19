import 'package:flutter/material.dart';
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
                left: 75,
                top: 195 + this.widget.xwidth + 50,
                width: this.widget.xwidth,
                height: this.widget.xheight),
                /*
                XRectangleTarget(
                left: 175,
                top: 195 + this.widget.xwidth + 50,
                width: this.widget.xwidth,
                height: this.widget.xheight),*/
            XRectangle(
              left: 75,
              top: 75,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: color,
            ),
            XRectangle(
                left: 195,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
            XTriangle(
                left: 315,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
            XTriangle(
                left: 75,
                top: 195,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
            XTriangle(
                left: 195,
                top: 195,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: color),
            XTriangle(
                left: 315,
                top: 195,
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
