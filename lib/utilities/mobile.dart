import 'package:flame/components.dart';

import 'package:mb/mb_world.dart';
import 'package:mb/utilities/behavior.dart';

import '../constants.dart';

mixin Mobile on PositionComponent, HasWorldReference<MBWorld> {
  late Behavior behavior;

  void updateMove(double dt) {
    Vector2 steering = behavior.move(dt);
    position.add(steering);
    Vector2 fs = size;
    position.clamp(fs/2, Vector2(maxWorldSizeX,maxWorldSizeY)-(fs*2));
  }
}
