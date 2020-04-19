import 'package:flutter/material.dart';
import 'package:tangram/rectangle.dart';
import 'package:tangram/triangle.dart';
import './observable.dart';

class XRectangleTarget extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xtriangleColor = Colors.grey;
  MaterialColor xcolor = Colors.grey;
  bool isTriangle = false;
  bool rotated = false;
  XRectangleTarget({double left, double top, double width, double height})
      : super(key: UniqueKey()) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
  }

  @override
  State<StatefulWidget> createState() {
    return _XRectangleTarget();
  }

  MaterialColor _defaultColor() {
    return this.xcolor;
  }

  void assign(Widget data) {
    if (data is XRectangle) {
      this.xcolor = data.xcolor;
      this.isTriangle = false;
    }
    if (data is XTriangle) {
      this.isTriangle = true;
      this.rotated = data.rotated;
      this.xtriangleColor = data.xcolor;
    }
  }
}

class _XRectangleTarget extends State<XRectangleTarget> {
  @override
  void initState() {
    super.initState();
    Observable obs = Observable();

    obs.subscribe('reset', (data) {
      setState(() {
        this.widget.xcolor = Colors.grey;
        this.widget.isTriangle = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var container = () {
      return Container(
        color: this.widget._defaultColor(),
        child: CustomPaint(
          painter: _XRectangleTargetPainter(widget: this.widget),
        ),
        width: this.widget.xwidth,
        height: this.widget.xheight,
      );
    };

    return Positioned(
        left: this.widget.xleft,
        top: this.widget.xtop,
        child: DragTarget(
          key: UniqueKey(),
          builder: (BuildContext ctx, List<Widget> data, rejectedData) {
            return container();
          },
          onWillAccept: (Widget data) {
            setState(() {
              this.widget.assign(data);
            });

            return true;
          },
          onAccept: (data) {
            setState(() {});
          },
        ));
  }
}

class _XRectangleTargetPainter extends CustomPainter {
  XRectangleTarget widget;
  _XRectangleTargetPainter({this.widget});

  @override
  void paint(Canvas canvas, Size size) {
    if (this.widget.isTriangle) {
      var path = Path();
      Paint paint = Paint();

      num w = this.widget.xwidth;
      num h = this.widget.xheight;

      paint.color = this.widget.xtriangleColor;
      if (this.widget.rotated)
        path.moveTo(w, h);
      else {
        path.moveTo(0, 0);
      }
      path.lineTo(w, 0);
      path.lineTo(0, h);
      path.close();
      canvas.drawPath(path, paint);
    } else {
      num w = this.widget.xwidth;
      num h = this.widget.xheight;
      Paint paint = Paint();
      paint.color = this.widget._defaultColor();
      var rect = Rect.fromLTWH(0, 0, w, h);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
  }
}
