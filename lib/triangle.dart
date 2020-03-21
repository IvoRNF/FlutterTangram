import 'package:flutter/material.dart';

class XTriangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  XTriangle(double left, double top, double width, double height,
      MaterialColor color) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
  }

  @override
  State<StatefulWidget> createState() {
    return _XTriangle();
  }
}

class _XTriangle extends State<XTriangle> {
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
                painter: _XTrianglePainter(this.widget.xwidth,this.widget.xheight,this.widget.xcolor),
              ),
              width: this.widget.xwidth,
              height: this.widget.xheight,
            )));
  }
}

class _XTrianglePainter extends CustomPainter 
{


  double xwidth = 0; 
  double xheight = 0; 
  MaterialColor xcolor;
  _XTrianglePainter(double width, double height, MaterialColor color)
  {

    this.xwidth = width; 
    this.xheight = height; 
    this.xcolor = color;
  }



  @override 
  void paint(Canvas canvas, Size size) 
  {
      var path = Path();
      Paint paint = Paint();
      paint.color = this.xcolor; 
      path.moveTo(0, 0);
      path.lineTo(0+this.xwidth, 0);
      path.lineTo(0,0+this.xheight);
      path.close();
      canvas.drawPath(path, paint);    
  }

  @override 
  bool shouldRepaint(CustomPainter olderRepainter)
  {
    return (olderRepainter != this);
  }
}
  

