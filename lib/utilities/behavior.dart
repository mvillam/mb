import 'dart:math';
import 'package:flame/components.dart';
import 'package:mb/components/figure_component.dart';
import 'package:mb/constants.dart';

class Behavior {
  Vector2 velocity = Vector2(0, 0);
  Behavior({required this.velocity});
  Vector2 move(double dt) {
    return velocity;
  }
}

mapRange(a1, a2, b1, b2, s) => (b1 + (s - a1) * (b2 - b1) / (a2 - a1));

class SeekBehavior extends Behavior {
  double minDist = worldTileSize * 1.5;
  double maxSpeed = worldTileSize * 2;

  FigureComponent figure;
  FigureComponent targetFigure;

  SeekBehavior(
      {required this.figure,
      required this.targetFigure,
      required this.maxSpeed,
      required this.minDist,
      required super.velocity});

  @override
  Vector2 move(double dt) {
    double dist = figure.position.distanceTo(targetFigure.position);
    double speed = maxSpeed;
    Vector2 desired = Vector2(0, 0);
    if (dist < minDist) {
      speed = mapRange(maxSpeed, 0, minDist, 0, dist / 5);
      desired =
          (targetFigure.position - figure.position).normalized() * speed * dt;
    }
    Vector2 steering = desired - velocity;
    steering.clampScalar(0, maxSpeed);
    figure.lookAt(targetFigure.position);
    return steering;
  }
}

class FleeBehavior extends Behavior {
  double maxSpeed = worldTileSize * 2;
  double minDist = worldTileSize * 4;

  FigureComponent figure;
  FigureComponent targetFigure;

  FleeBehavior(
      {required this.figure,
      required this.targetFigure,
      required this.maxSpeed,
      required this.minDist,
      required super.velocity});

  @override
  Vector2 move(double dt) {
    double dist = figure.position.distanceTo(targetFigure.position);
    Vector2 steering = Vector2(0, 0);
    if (dist < minDist) {
      Vector2 desired = (figure.position - targetFigure.position).normalized() *
          maxSpeed *
          dt;
      steering = desired - velocity;
      steering.clampScalar(0, maxSpeed);
      figure.lookAt(targetFigure.position);
      figure.angle += pi;
    }
    return steering;
  }
}

class PursueBehavior extends Behavior {
  double minDist = worldTileSize * 1.5;
  double maxSpeed = worldTileSize * 2;
  double maxForce = worldTileSize / 10;

  FigureComponent figure;
  FigureComponent targetFigure;

  PursueBehavior(
      {required this.figure,
      required this.targetFigure,
      required this.maxSpeed,
      required this.minDist,
      required super.velocity});

  @override
  Vector2 move(double dt) {
    double dist = figure.position.distanceTo(targetFigure.position);
    double speed = maxSpeed;
    Vector2 desired = Vector2(0, 0);
    if (dist < minDist) {
      speed = mapRange(maxSpeed, 0, minDist, 0, dist / 5);
      desired = (targetFigure.position +
                  targetFigure.behavior.velocity -
                  figure.position)
              .normalized() *
          speed *
          dt;
    }
    Vector2 steering = desired - velocity;
    steering.clampScalar(0, maxSpeed);
    figure.lookAt(targetFigure.position);
    return steering;
  }
}

class EvadeBehavior extends Behavior {
  double maxSpeed = worldTileSize * 2;
  double minDist = worldTileSize * 4;

  FigureComponent figure;
  FigureComponent targetFigure;

  EvadeBehavior(
      {required this.figure,
      required this.targetFigure,
      required this.maxSpeed,
      required this.minDist,
      required super.velocity});

  @override
  Vector2 move(double dt) {
    double dist = figure.position.distanceTo(targetFigure.position);
    Vector2 steering = Vector2(0, 0);
    if (dist < minDist) {
      Vector2 desired = (figure.position -
                  targetFigure.position +
                  targetFigure.behavior.velocity)
              .normalized() *
          maxSpeed *
          dt;
      steering = desired - velocity;
      steering.clampScalar(0, maxSpeed);
      figure.lookAt(targetFigure.position);
      figure.angle += pi;
    }
    return steering;
  }
}
