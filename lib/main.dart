import 'package:flutter/material.dart';
import './rectangle.dart';
import './triangle.dart';

void main() => runApp(TangramApp());

class TangramApp extends StatefulWidget {
  final String title = 'Tangram';
  bool isSel = false;
  num xwidth = 100;
  num xheight = 100;
  List<Widget> drawedWidgets = [];

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

 
  void panUpdate()
  {
     
     setState(() {
        this.widget.isSel = false;
     }); 
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
                75,
                195 + this.widget.xwidth + 50,
                this.widget.xwidth * 2,
                this.widget.xheight * 2,
                Colors.grey,
                false,
                false,
                null,
                UniqueKey()),
            XRectangle(75, 75, this.widget.xwidth, this.widget.xheight,
                Colors.blue, this.widget.isSel, true,panUpdate ,UniqueKey()),
            XRectangle(195, 75, this.widget.xwidth,this.widget.xheight,
                Colors.red, this.widget.isSel, true,panUpdate, UniqueKey()),
            XRectangle(315, 75, this.widget.xwidth, this.widget.xheight,
                Colors.green, this.widget.isSel, true,panUpdate ,UniqueKey()),
            XTriangle(75, 195, this.widget.xwidth, this.widget.xheight,
                Colors.orange),
            XTriangle(
                195, 195, this.widget.xwidth, this.widget.xheight, Colors.pink),
            XTriangle(315, 195, this.widget.xwidth, this.widget.xheight,
                Colors.purple),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
          child: Icon(Icons.rotate_right),
        ),
      ),
    );
  }
}
