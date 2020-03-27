import 'package:flutter/material.dart';
import './rectangle.dart';
import './triangle.dart';

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
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  void onTap(int index) {
    /*setState(() {
      this._selectedIndex = index;
    });*/
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
                selectedIndex: this._selectedIndex,
                index: 0,
                dragable: true,
                onTap: this.onTap,
                key: UniqueKey()),
            XRectangle(
                left: 75,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.blue,
                selectedIndex: this._selectedIndex,
                index: 1,
                dragable: true,
                onTap: this.onTap,
                key: UniqueKey()),
            XRectangle(
                left: 195,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.red,
                selectedIndex: this._selectedIndex,
                index: 2,
                dragable: true,
                onTap: this.onTap,
                key: UniqueKey()),
            XRectangle(
                left: 315,
                top: 75,
                width: this.widget.xwidth,
                height: this.widget.xheight,
                color: Colors.green,
                selectedIndex: this._selectedIndex,
                index: 3,
                dragable: true,
                onTap: this.onTap,
                key: UniqueKey()),
            XTriangle(75, 195, this.widget.xwidth, this.widget.xheight,
                Colors.orange),
            XTriangle(
                195, 195, this.widget.xwidth, this.widget.xheight, Colors.pink),
            XTriangle(315, 195, this.widget.xwidth, this.widget.xheight,
                Colors.purple),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.rotate_right),
        ),
      ),
    );
  }
}
