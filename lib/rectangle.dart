import 'package:flutter/material.dart';
import './observable.dart';

class XRectangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  int selectedIndex = -1;
  int index = 0;
  bool dragable = true;

  XRectangle(
      {double left,
      double top,
      double width,
      double height,
      MaterialColor color,
      int index,
      bool dragable,
      Key key})
      : this.index = index,
        this.dragable = dragable,
        super(key: key) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
  }

  bool get isSelected {
    return ((this.selectedIndex ?? 0) == (this.index ?? 0) && this.dragable);
  }

  @override
  State<StatefulWidget> createState() {
    return _XRectangle();
  }
}

class _XRectangle extends State<XRectangle> {
  @override
  void initState() {
    Observable obs = Observable();
    obs.subscribe('changeSelection',(int selIndex) {
      setState(() {
        this.widget.selectedIndex = selIndex;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: this.widget.xleft,
        top: this.widget.xtop,
        child: GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!this.widget.dragable) return;

              setState(() {
                this.widget.xleft += tapInfo.delta.dx;
                this.widget.xtop += tapInfo.delta.dy;
                Observable obs = Observable();
                obs.notify('changeSelection',this.widget.index);
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
