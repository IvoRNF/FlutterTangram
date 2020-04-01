import 'package:flutter/material.dart';
import './rectangle.dart';
import './triangle.dart';
import './observable.dart';

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
    return MaterialApp(
      title: this.widget.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.widget.title),
        ),
        body: Stack(
          children: [
            XRectangle(
                left: 75,
                top: 195 + this.widget.xwidth + 50,
                width: this.widget.xwidth * 2,
                height: this.widget.xheight * 2,
                color: Colors.grey,
                dragable: false),
            XRectangle(
              left: 75,
              top: 75,
              width: this.widget.xwidth,
              height: this.widget.xheight,
              color: Colors.blue,
            ),
            XRectangle(
                left: 195,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.red),
            XTriangle(
                left: 315,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.green),
            XTriangle(
                left: 75,
                top: 195,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.orange),
            XTriangle(
                left: 195,
                top: 195,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.pink),
            XTriangle(
                left: 315,
                top: 195,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.purple),
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
