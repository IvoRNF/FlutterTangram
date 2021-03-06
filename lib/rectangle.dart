import 'package:flutter/material.dart';
import './model.dart';

class XRectangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  bool visible = true;
  Key selectedKey = UniqueKey();
  XRectangle(
      {double left,
      double top,
      double width,
      double height,
      MaterialColor color})
      : super(key: UniqueKey()) {
    this.xleft = left;
    this.xtop = top;
    this.xwidth = width;
    this.xheight = height;
    this.xcolor = color;
  }

  bool get isSelected {
    return (this.selectedKey == this.key);
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
   
    Model.onChangeSelection.listen( (Key selKey) {
      setState(() {
        this.widget.selectedKey = selKey;
      });
    });

    Model.onReset.listen( (data) {
      setState(() {
        this.widget.visible = true;
      });
    });
  }

  _changeSelection() {
    Model.doChangeSelection.add(this.widget.key);
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      child: CustomPaint(
        painter: _XRectanglePainter(widget: this.widget),
      ),
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
            child: this.widget.visible && (!Model.contains(this.widget))
                ? container
                : Container(),
            feedback: container,
            childWhenDragging: Container()));
  }
}

class _XRectanglePainter extends CustomPainter {
  XRectangle widget;
  _XRectanglePainter({this.widget});

  @override
  void paint(Canvas canvas, Size size) {
    num strokeWidth = 2;
    num w = this.widget.xwidth;
    num h = this.widget.xheight;
    if (this.widget.isSelected) {
      w -= strokeWidth;
      h -= strokeWidth;
    }

    Paint paint = Paint();
    paint.color = this.widget.xcolor;
    var rect = Rect.fromLTWH(0, 0, w, h);
    canvas.drawRect(rect, paint);

    if (this.widget.isSelected) {
      var path = Path();
      paint.color = Colors.black;
      paint.strokeWidth = strokeWidth;
      paint.style = PaintingStyle.stroke;
      path.lineTo(0, w);
      path.lineTo(w, h);
      path.lineTo(w, 0);
      path.lineTo(0, 0);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter olderRepainter) {
    return (olderRepainter != this);
  }
}
