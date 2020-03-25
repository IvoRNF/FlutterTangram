import 'package:flutter/material.dart';
import './rectangle.dart';
import './triangle.dart';

void main() => runApp(TangramApp());

class TangramApp extends StatefulWidget {
  final String title = 'Tangram';
  List<Widget> drawedWidgets = [];


 

   @override
  State<StatefulWidget> createState() {
    return _TangramApp();
  }

  
}
class _TangramApp extends State<TangramApp>
{
  @override
  Widget build(BuildContext context) {
    this.widget.drawedWidgets.clear();

    var drawRectangle =
        (double l, double t, double w, double h, MaterialColor cl) {
      this.widget.drawedWidgets.add(XRectangle(l, t, w, h, cl,this.widget.drawedWidgets,UniqueKey()));
    };

    var drawTriangle =
        (double l, double t, double w, double h, MaterialColor cl) {
      this.widget.drawedWidgets.add(XTriangle(l, t, w, h, cl));
    };

    num left = 75;
    num initLeft = left;
    num top = 75;
    num wh = 100;
    drawRectangle(left, top, wh, wh, Colors.blue);
    left = left + wh + 20;
    drawRectangle(left, top, wh, wh, Colors.red);
    left = left + wh + 20;
    drawTriangle(left, top, wh, wh, Colors.green);

    left = initLeft;
    top = top + wh + 20;
    drawTriangle(left, top, wh, wh, Colors.orange);
    left = left + wh + 20;
    drawTriangle(left, top, wh, wh, Colors.pink);
    left = left + wh + 20;
    drawTriangle(left, top, wh, wh, Colors.purple);
    //quadro
    drawRectangle(initLeft, top + wh + 50, wh * 2, wh * 2, Colors.grey);

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
          children: this.widget.drawedWidgets,
        ),
      ),
    );
  }
}
