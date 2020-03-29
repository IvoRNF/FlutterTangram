import 'package:flutter/material.dart';
import './observable.dart';

class XTriangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  Key selectedKey = UniqueKey();
  bool dragable = true;

  XTriangle(
      {double left,
      double top,
      double width,
      double height,
      MaterialColor color,
      bool dragable = true})
      : this.dragable = dragable,
        super(key: UniqueKey()) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
  }

  bool get isSelected {
    return ((this.selectedKey == this.key) && this.dragable);
  }

  @override
  State<StatefulWidget> createState() {
    return _XTriangle();
  }
}

class _XTriangle extends State<XTriangle> {
  @override
  void initState() {
    super.initState();
    Observable obs = Observable();
    obs.subscribe('changeSelection', (Key selKey) {
      setState(() {
        this.widget.selectedKey = selKey;
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
                obs.notify('changeSelection', this.widget.key);
              });
            },
            child: Container(
              child: CustomPaint(
                painter: _XTrianglePainter(
                    this.widget.xwidth,
                    this.widget.xheight,
                    this.widget.xcolor,
                    this.widget.isSelected),
              ),
              width: this.widget.xwidth,
              height: this.widget.xheight,
            )));
  }
}

class _XTrianglePainter extends CustomPainter {
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  bool isSelected = false;
  _XTrianglePainter(
      double width, double height, MaterialColor color, bool isSelected) {
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
    this.isSelected = isSelected;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    Paint paint = Paint();
    paint.color = this.xcolor;
    path.moveTo(0, 0);
    path.lineTo(0 + this.xwidth, 0);
    path.lineTo(0, 0 + this.xheight);
    path.close();
    canvas.drawPath(path, paint);

    if (this.isSelected) {
      path.moveTo(0, 0);
      path.lineTo(0 + this.xwidth, 0);
      path.lineTo(0, 0 + this.xheight);
      path.lineTo(0, 0);
      path.close();
      paint.color = Colors.black;
      paint.strokeWidth = 3.0;
      paint.style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
  }
}
