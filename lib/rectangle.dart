import 'package:flutter/material.dart';

class XRectangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  bool isSelected = false;
  bool dragable = true;
  
  Function panUpdate;
  XRectangle(double left, double top, double width, double height,
      MaterialColor color, bool isSelected ,bool dragable,Function panUpdate, Key key) 
  :  this.isSelected = isSelected, this.dragable = dragable,this.panUpdate = panUpdate ,super(key : key)  
    
  {
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
                 
                if(!this.widget.dragable)
                  return;
                //if(this.widget.panUpdate != null)
                  //this.widget.panUpdate();
                this.widget.isSelected = true;
                this.widget.xleft += tapInfo.delta.dx;
                this.widget.xtop += tapInfo.delta.dy;

              });
            },
            child: Container(
              decoration: (this.widget.isSelected && this.widget.dragable)
                  ? BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 5))
                  : null,
              child: CustomPaint(
                painter: _XRectanglePainter(this.widget.xwidth,
                    this.widget.xheight, this.widget.xcolor),
              ),
              width: (this.widget.isSelected && this.widget.dragable)
                  ? this.widget.xwidth + 10
                  : this.widget.xwidth,
              height: this.widget.isSelected
                  ? this.widget.xheight + 10
                  : this.widget.xheight,
            )));
  }
}

class _XRectanglePainter extends CustomPainter {
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  _XRectanglePainter(double width, double height, MaterialColor color) {
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = this.xcolor;
    var rect = Rect.fromLTWH(0, 0, this.xwidth, this.xheight);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
    
  }
}
