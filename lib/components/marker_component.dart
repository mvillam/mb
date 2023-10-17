import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:mb/constants.dart';

class MarkerComponent extends PositionComponent {
  MarkerComponent(Vector2 position, Vector2 size,
      [this.color = const Color(0xFF000000)])
      : super(
            anchor: Anchor.center,
            position: position,
            size: size,
            priority: 100);

  factory MarkerComponent.red(Vector2 position, Vector2 size) =>
      MarkerComponent(
        position,
        size,
        const Color(0xFFFF0000),
      );

  factory MarkerComponent.green(Vector2 position, Vector2 size) =>
      MarkerComponent(
        position,
        size,
        const Color(0xFF00FF00),
      );

  factory MarkerComponent.blue(Vector2 position, Vector2 size) =>
      MarkerComponent(
        position,
        size,
        const Color(0xFF0000FF),
      );

  final Color color;

  @override
  void onLoad() {
    final Paint paint = Paint();
    paint.color = color;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    List<Vector2> vlist=[Vector2(worldTileSize/2,0),Vector2(worldTileSize,worldTileSize),Vector2(0,worldTileSize)];
    addAll(
      [RectangleComponent(position: position,size: size,paint: paint),
      PolygonComponent(vlist,position:position,
        paint: paint,
        size: size,
      )]
    );
  }
}
