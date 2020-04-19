import 'package:flutter/material.dart';
import './observable.dart';

class XRectangle extends StatefulWidget {
  double xleft = 0;
  double xtop = 0;
  double xwidth = 0;
  double xheight = 0;
  MaterialColor xcolor;
  bool visible = true;
  Key selectedKey = UniqueKey();
  bool dragable = true;
  bool dragged = false;
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

    obs.subscribe('reset', (data) {
      setState(() {
        if (!this.widget.dragable) this.widget.xcolor = Colors.grey;
        this.widget.visible = true;
        this.widget.dragged = false;
      });
    });
  }

  _changeSelection() {
    Observable obs = Observable();
    obs.notify('changeSelection', this.widget.key);
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
    if (this.widget.dragable) {
      return Positioned(
          left: this.widget.xleft,
          top: this.widget.xtop,
          child: Draggable(
              key: UniqueKey(),
              data: this.widget.runtimeType.toString(),
              onDragStarted: () {
                setState(() {
                  this.widget.visible = false;
                  this._changeSelection();
                });
              },
              onDraggableCanceled: (velocity, offset) =>
                  setState(() => this.widget.visible = true),
              onDragCompleted: () =>
                  setState(() => this.widget.visible = false),
              child: this.widget.visible ? container : Container(),
              feedback: container,
              childWhenDragging: Container()));
    }
    return Positioned(
        left: this.widget.xleft,
        top: this.widget.xtop,
        child: DragTarget(
          key: UniqueKey(),
          builder: (BuildContext ctx, List<String> data, rejectedData) {
            return container;
          },
          onWillAccept: (String data) {
            this.widget.xcolor = Colors.blue;
           // print(data);
            return true;
          },
          onAccept: (data) {
            setState(() => this.widget.dragged = true);
          },
        ));
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
