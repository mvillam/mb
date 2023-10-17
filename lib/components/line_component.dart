import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:mb/utilities/line.dart';

class LineComponent extends PositionComponent {
  Line line;
  final Color color;
  final double thickness;

  LineComponent({
    required this.line,
    double? thickness = 1,
    this.color = const Color(0xFF000000),
  })  : assert(thickness != null),
        thickness = thickness!,
        super(
          anchor: Anchor.center,
          position: line.start,
          priority: 3,
          size: Vector2(line.length, 1),
        );

  factory LineComponent.red({
    required Line line,
    bool? debug = false,
    double? thickness = 3,
  }) =>
      LineComponent(
        line: line,
        color: const Color(0xFFFF0000),
        thickness: thickness,
      );

  factory LineComponent.green({
    required Line line,
    bool? debug = false,
    double? thickness = 3,
  }) =>
      LineComponent(
        line: line,
        color: const Color(0xFF00FF00),
        thickness: thickness,
      );

  factory LineComponent.blue({
    required Line line,
    bool? debug = false,
    double? thickness = 3,
  }) =>
      LineComponent(
        line: line,
        color: const Color(0xFF0000FF),
        thickness: thickness,
      );

  Vector2 get lineCenter => line.center;

  @override
  NotifyingVector2 get size => NotifyingVector2(line.dx, line.dy);
}
