import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:vector_math/vector_math_64.dart';

class Line extends Equatable {
  final Vector2 start;
  final Vector2 end;

  Line(this.start, this.end);

  factory Line.doubles(
      double startX,
      double startY,
      double endX,
      double endY,
      ) =>
      Line(Vector2(startX, startY), Vector2(endX, endY));

  List<double> asList() => [start.x, start.y, end.x, end.y];

  double? get slope {
    if (start.x == end.x) return null;
    return dy / dx;
  }

  late final double dx = end.x - start.x;
  late final double dy = end.y - start.y;

  Vector2 get center => (start + end) / 2;

  Line extend(double multiplier) {
    final longerVector = vector2 * multiplier;
    return Line(start, longerVector + start);
  }

  Vector2? _vector2;
  Vector2 get vector2 {
    _vector2 ??= Vector2(end.x - start.x, end.y - start.y);
    return _vector2!;
  }

  double? _length;
  double get length {
    _length = sqrt(pow(dx, 2) + pow(dy, 2));
    return _length!;
  }

  double? _length2;
  double get length2 {
    _length2 = pow(dx, 2).toDouble() + pow(dy, 2).toDouble();
    return _length2!;
  }

  @override
  List<Object?> get props => [start,end];
}
