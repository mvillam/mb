import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/painting.dart';
import 'package:mb/components/line_component.dart';


enum MarkerType { line, triangle, circle, rectangle }

class MarkerComponent extends PositionComponent with HasVisibility{
  late Paint paint;
  Color color;
  MarkerType type;

  MarkerComponent(
      {super.position,
      super.size,
      this.type = MarkerType.circle,
      this.color = const Color.fromRGBO(255, 0, 0, 1)}) {
    anchor = Anchor.center;
    paint = Paint();
    paint.color = color;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    priority = 100;
  }

  @override
  void onLoad() {
    Vector2 s_2= size/2;
    switch (type) {
      case MarkerType.line:
        add(LineComponent(segment: LineSegment(position,Vector2(position.x,position.y- size.y/2)),paint: paint));
        break;
      case MarkerType.triangle:
        List<Vector2> list = [Vector2(-s_2.x, size.y),Vector2(s_2.x, size.y), Vector2(0,  0)];
        add(PolygonComponent(list,anchor: Anchor.center,
            position: position, paint: paint, size: size, priority: priority));
        break;
      case MarkerType.circle:
        add(CircleComponent(anchor: Anchor.center,position: position,radius: size.x/2,paint: paint,priority: priority));
        break;
      case MarkerType.rectangle:
        add(RectangleComponent(anchor: Anchor.center,position: position,size: size,paint: paint,priority: priority));
        break;
    }
  }
}
