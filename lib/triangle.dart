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
  bool rotated = false;
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

    obs.subscribe('rotate', (value) {
      setState(() {
        if (this.widget.isSelected) this.widget.rotated = !this.widget.rotated;
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
                painter: _XTrianglePainter(widget: this.widget),
              ),
              width: this.widget.xwidth,
              height: this.widget.xheight,
            )));
  }
}

class _XTrianglePainter extends CustomPainter {
  XTriangle widget;
  _XTrianglePainter({this.widget});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    Paint paint = Paint();

    paint.color = this.widget.xcolor;
    if (this.widget.rotated)
      path.moveTo(this.widget.xwidth, this.widget.xheight);
    else {
      path.moveTo(0, 0);
    }
    path.lineTo(this.widget.xwidth, 0);
    path.lineTo(0, this.widget.xheight);
    path.close();
    canvas.drawPath(path, paint);

    if (this.widget.isSelected) {
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
