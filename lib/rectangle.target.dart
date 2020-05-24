import 'package:flutter/material.dart';
import 'package:tangram/rectangle.dart';
import 'package:tangram/triangle.dart';
import './model.dart';

class XRectangleTarget extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor = Colors.grey;

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
}

class _XRectangleTarget extends State<XRectangleTarget> {
  @override
  void initState() {
    super.initState();
    Model.onReset.listen((data) {
      setState(() {
        this.widget.xcolor = Colors.grey;
        Model.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var container = () {
      return Container(
        color: Colors.grey,
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
            if (Model.contains(this.widget)) {
              return false;
            }

            if (Model.len(this.widget.key) == 1) {
              if (data is XRectangle) {
                return false;
              }
              if (data is XTriangle) {
                if (!Model.containsInversedTriangle(
                    this.widget.key, data.rotated)) {
                  return false;
                }
              }
            }
            if (Model.len(this.widget.key) == 2) return false;
            return true;
          },
          onAccept: (data) {
            setState(() => Model.add(this.widget.key, data));
          },
        ));
  }
}

class _XRectangleTargetPainter extends CustomPainter {
  XRectangleTarget widget;
  _XRectangleTargetPainter({this.widget});

  @override
  void paint(Canvas canvas, Size size) {
    bool isTriangle = false;
    Key k = this.widget.key;

    isTriangle = Model.containsOneTriangle(k);

    bool twoTri = Model.containsTwoTriangle(k);

    if (Model.containsOneRectangle(k) || twoTri) isTriangle = false;

    var drawXTrian = (XTriangle trian) {
      var path = Path();
      Paint paint = Paint();

      num w = this.widget.xwidth;
      num h = this.widget.xheight;

      paint.color = trian.xcolor;
      if (trian.rotated)
        path.moveTo(w, h);
      else {
        path.moveTo(0, 0);
      }
      path.lineTo(w, 0);
      path.lineTo(0, h);
      path.close();
      canvas.drawPath(path, paint);
    };
    if (twoTri) {
      List<Widget> lis = Model.find(k);
      drawXTrian(lis.first as XTriangle);
      drawXTrian(lis.last as XTriangle);
    } else if (isTriangle) {
      List<Widget> lis = Model.find(k);
      drawXTrian(lis.first as XTriangle);
    } else {
      List<Widget> lis = Model.find(k);
      MaterialColor c = Colors.grey;
      if (lis != null) {
        if (lis.length > 0) {
          XRectangle recta = lis.first;
          c = recta.xcolor;
        }
      }

      num w = this.widget.xwidth;
      num h = this.widget.xheight;
      Paint paint = Paint();
      paint.color = c;
      var rect = Rect.fromLTWH(0, 0, w, h);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
  }
}
