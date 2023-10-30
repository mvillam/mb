import 'dart:ui';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:mb/constants.dart';

class PathComponent extends PositionComponent{
  List<Vector2> points =[];
  late Path path;
  late final Paint borderPaint;
  late final Paint mainPaint;

  PathComponent(this.points);

  @override
  Future<void> onLoad() async {
    initPath();
    borderPaint = Paint()
      ..color = const Color.fromRGBO(0,0,0,1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    mainPaint = Paint()
      ..color = const Color.fromRGBO(0,0,0,0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = worldTileSize*3;
  }

  Rect boundingRect() {
    var minX = double.infinity;
    var minY = double.infinity;
    var maxX = -double.infinity;
    var maxY = -double.infinity;
    for (final point in points) {
      minX = min(minX, point.x);
      minY = min(minY, point.y);
      maxX = max(maxX, point.x);
      maxY = max(maxY, point.y);
    }
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  void initPath()
  {
    path = Path();
    if(points.isNotEmpty) {
      path.moveTo(points[0].x, points[0].y);
      for (final Vector2 p in points) {
        path.lineTo(p.x, p.y);
      }
      path.lineTo(points[0].x, points[0].y);
    }
  }

  @override
  void render(Canvas canvas) {
    //canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, mainPaint);
  }
  
}