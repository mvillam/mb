import 'dart:math';

import 'package:flame/components.dart';

mixin Utilities
{
  mapRange(a1, a2, b1, b2, s) => (b1 + (s - a1) * (b2 - b1) / (a2 - a1));
  double randomDoubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  Vector2 vector2Projection(Vector2 pos, Vector2 a,Vector2 b)
  {
    Vector2 v1 = a-pos;
    Vector2 v2 = (b-pos).normalized();
    double sp=v1.dot(v2);
    return v2*sp+pos;
  }

}