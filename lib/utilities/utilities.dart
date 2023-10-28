import 'dart:math';

mixin Utilities
{
  mapRange(a1, a2, b1, b2, s) => (b1 + (s - a1) * (b2 - b1) / (a2 - a1));
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}