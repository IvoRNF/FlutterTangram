import 'package:flutter/material.dart';

class XRectangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  XRectangle(double left, double top, double width, double height,
      MaterialColor color) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
  }

  @override
  State<StatefulWidget> createState() {
    return _XRectangle();
  }
}

class _XRectangle extends State<XRectangle> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: this.widget.xleft,
        top: this.widget.xtop,
        child: GestureDetector(
            onPanUpdate: (tapInfo) {
              setState(() {
                this.widget.xleft += tapInfo.delta.dx;
                this.widget.xtop += tapInfo.delta.dy;
              });
            },
            child: Container(
              child: CustomPaint(
                painter: _XRectanglePainter(this.widget.xwidth,this.widget.xheight,this.widget.xcolor),
              ),
              width: this.widget.xwidth,
              height: this.widget.xheight,
            )));
  }
}

class _XRectanglePainter extends CustomPainter 
{


  double xwidth = 0; 
  double xheight = 0; 
  MaterialColor xcolor;
  _XRectanglePainter(double width, double height, MaterialColor color)
  {

    this.xwidth = width; 
    this.xheight = height; 
    this.xcolor = color;
  }



  @override 
  void paint(Canvas canvas, Size size) 
  {
     Paint paint = Paint();
     paint.color = this.xcolor; 
     var rect = Rect.fromLTWH(0,0,this.xwidth,this.xheight);
     canvas.drawRect(rect, paint);     
  }

  @override 
  bool shouldRepaint(CustomPainter olderRepainter)
  {
    return (olderRepainter != this);
  }
}
  

