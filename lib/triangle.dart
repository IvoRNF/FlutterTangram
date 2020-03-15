import 'package:flutter/material.dart';
import 'control.dart';




class Triangle extends StatefulWidget with Control
{
  
  Triangle(double left , double top , double width, double height, MaterialColor color)
  {
    this.left = left;
    this.top = top;
    this.width = width; 
    this.height = height; 
    this.color = color;
  }
   
  @override 
  State<StatefulWidget> createState() {
    
    return _Trinangle();
  }

}

class _Trinangle extends State<Triangle>
{
    @override
  Widget build(BuildContext context) 
  {
    return Container(

      child: CustomPaint(
        painter: _TrianglePainter(),
      ),
      
    );
  }
}

class _TrianglePainter extends CustomPainter
{
  @override 
  void paint(Canvas canvas, Size size) 
  {

     var drawRectangle = (double l , double t , double w , double h, MaterialColor cl){
      Paint paint = Paint();
      paint.color = cl; 
      var rect = Rect.fromLTWH(l,t,w,h);
      canvas.drawRect(rect, paint);
    };
    
  }

  @override 
  bool shouldRepaint(CustomPainter olderRepainter)
  {
    return (olderRepainter != this);
  }
}
  
