import 'package:flutter/material.dart';
import './observable.dart';

class XTriangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  Key selectedKey = UniqueKey();
  bool rotated = false;
  bool visible = true;
  XTriangle(
      {double left,
      double top,
      double width,
      double height,
      MaterialColor color,
      bool rotated = false})
      : super(key: UniqueKey()) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
    this.rotated = rotated;
  }

  bool get isSelected {
    return (this.selectedKey == this.key);
  }

  void assign(XTriangle rect)
  {
    this.xcolor = rect.xcolor;
    this.xwidth = rect.xwidth;
    this.xheight = rect.xheight;
    this.rotated = rect.rotated;
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

    obs.subscribe('reset', (data) {
      setState(() {
        this.widget.visible = true;
      });
    });
  }

  _changeSelection() {
    Observable obs = Observable();
    obs.notify('changeSelection', this.widget.key);
  }

  @override
  Widget build(BuildContext context) {
    var cpaint = CustomPaint(
      painter: _XTrianglePainter(widget: this.widget),
    );
    Widget container = Container(
      child: cpaint,
      width: this.widget.xwidth,
      height: this.widget.xheight,
    );

    Widget data = this.widget;

    return Positioned(
        left: this.widget.xleft,
        top: this.widget.xtop,
        child: Draggable(
            key: UniqueKey(),
            data: data,
            onDragStarted: () {
              setState(() {
                this.widget.visible = false;
                this._changeSelection();
              });
            },
            onDraggableCanceled: (velocity, offset) =>
                setState(() => this.widget.visible = true),
            onDragCompleted: () => setState(() => this.widget.visible = false),
            child: this.widget.visible ? container : Container(),
            feedback: container,
            childWhenDragging: Container()));
  }
}

class _XTrianglePainter extends CustomPainter {
  XTriangle widget;
  _XTrianglePainter({this.widget});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    Paint paint = Paint();

    num w = this.widget.xwidth;
    num h = this.widget.xheight;
    num strokeWidth = 2;
    if (this.widget.isSelected) {
      w -= strokeWidth;
      h -= strokeWidth;
    }

    paint.color = this.widget.xcolor;
    if (this.widget.rotated)
      path.moveTo(w, h);
    else {
      path.moveTo(0, 0);
    }
    path.lineTo(w, 0);
    path.lineTo(0, h);
    path.close();
    canvas.drawPath(path, paint);

    if (this.widget.isSelected) {
      paint.color = Colors.black;
      paint.strokeWidth = strokeWidth;
      paint.style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
  }
}
