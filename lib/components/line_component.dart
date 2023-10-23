import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

class LineComponent extends ShapeComponent {
  LineSegment segment;

  LineComponent({required this.segment,super.position,super.size,super.paint,super.priority});


  @override
  bool containsPoint(Vector2 point) {
    return segment.containsPoint(point);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawLine(segment.from.toOffset(), segment.to.toOffset(), paint);
  }
}
