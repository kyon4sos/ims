import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CircleIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CircleIndicator();
  }
}

class _CircleIndicator extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint p = Paint();
    p.strokeWidth = 3.0;
    p.style = PaintingStyle.stroke;
    p.color = Colors.pink;
    canvas.drawCircle(offset.translate(34.0, 0), 4.0, p);
  }
}
