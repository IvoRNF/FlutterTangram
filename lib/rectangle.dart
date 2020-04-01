import 'package:flutter/material.dart';
import './observable.dart';

class XRectangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  Key selectedKey = UniqueKey();
  bool dragable = true;

  XRectangle(
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
    return _XRectangle();
  }
}

class _XRectangle extends State<XRectangle> {
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
                painter: _XRectanglePainter(widget: this.widget),
              ),
              width: this.widget.xwidth,
              height: this.widget.xheight,
            )));
  }
}

class _XRectanglePainter extends CustomPainter {
  XRectangle widget;
  _XRectanglePainter({this.widget});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = this.widget.xcolor;
    var rect = Rect.fromLTWH(0, 0, this.widget.xwidth, this.widget.xheight);
    canvas.drawRect(rect, paint);

    if (this.widget.isSelected) {
      var path = Path();
      paint.color = Colors.black;
      paint.strokeWidth = 3.0;
      paint.style = PaintingStyle.stroke;
      path.lineTo(0, this.widget.xwidth);
      path.lineTo(this.widget.xwidth, this.widget.xheight);
      path.lineTo(this.widget.xwidth, 0);
      path.lineTo(0, 0);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
  }
}
