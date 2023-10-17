import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';
import 'package:mb/mb_world.dart';
import 'package:mb/utilities/mobile.dart';

import '../utilities/behavior.dart';
import 'marker_component.dart';
import '../constants.dart';

class FigureComponent extends PositionComponent
    with HasWorldReference<MBWorld>, Mobile {

  Color color;
  late MarkerComponent box;

  FigureComponent(
      {required Vector2 position,
      required Vector2 size,
      required this.color,
      required Behavior behavior})
      : super(position: position) {
    anchor = Anchor.center;
    box = MarkerComponent(Vector2(0, 0), size, color);
    this.behavior = behavior;
  }

  factory FigureComponent.red(Vector2 position, Vector2 size) =>
      FigureComponent(
          position: position,
          size: size,
          color: const Color.fromARGB(255, 255, 0, 0),
          behavior: Behavior(velocity:Vector2(0, 0)));

  factory FigureComponent.green(Vector2 position, Vector2 size) =>
      FigureComponent(
          position: position,
          size: size,
          color: const Color.fromARGB(255, 0, 255, 0),
          behavior: Behavior(velocity:Vector2(0, 0)));

  factory FigureComponent.blue(Vector2 position, Vector2 size) =>
      FigureComponent(
          position: position,
          size: size,
          color: const Color.fromARGB(255, 0, 0, 255),
          behavior: Behavior(velocity:Vector2(0, 0)));

  @override
  void onLoad() {
    box.anchor = Anchor.center;
    add(box);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateMove(dt);

  }
}
