import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(TangramApp());

class TangramApp extends StatelessWidget {

  final String title = 'Tangram';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Container(

          child: CustomPaint(
            painter: MyPainter(), 

          ),
        ),
      ),
    );
  }
}


class MyPainter extends CustomPainter
{

@override 
void paint(Canvas canvas, Size size) 
{    
    var drawRectangle = (double l , double t , double w , double h, MaterialColor cl){
      Paint paint = Paint();
      paint.color = cl; 
      var rect = Rect.fromLTWH(l,t,w,h);
      canvas.drawRect(rect, paint);
    };

    var drawTriangle = (double l , double t , double w, double h,MaterialColor cl){


       var path = Path();
       Paint paint = Paint();
       paint.color = cl; 
       path.moveTo(l, t);
       path.lineTo(l+w, t);
       path.lineTo(l,t+h);
       path.close();
       canvas.drawPath(path, paint);


    } ;  
    num left = 75;
    num initLeft = left;
    num top = 75;
    num wh = 100;
    drawRectangle(left,top,wh,wh,Colors.blue);  
    left = left + wh + 20 ;
    drawRectangle(left,top,wh,wh,Colors.red);
    left = left + wh + 20 ;
    drawTriangle(left,top,wh,wh,Colors.green );

    left = initLeft;
    top = top + wh + 20;
    drawTriangle(left,top,wh,wh,Colors.orange );
    left = left + wh + 20 ;
    drawTriangle(left,top,wh,wh,Colors.pink);
    left = left + wh + 20 ;
    drawTriangle(left,top,wh,wh,Colors.purple );
    //quadro
    drawRectangle(initLeft,top+wh+50,wh*2,wh*2,Colors.grey);

}

@override 
bool shouldRepaint(CustomPainter oldPainter) => true;


}

