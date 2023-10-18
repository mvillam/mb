import 'package:flame/components.dart';
import 'package:mb/components/figure_component.dart';

class Behavior {
  double minDist;
  double maxSpeed;
  double maxForce;

  mapRange(a1, a2, b1, b2, s) => (b1 + (s - a1) * (b2 - b1) / (a2 - a1));
  Behavior(
      {this.minDist =0, this.maxSpeed=0,this.maxForce=0});
  Vector2 move(double dt) {
    return Vector2(0, 0);
  }
}

class GoToBehavior extends Behavior {
  FigureComponent figure;
  Vector2 target;

  GoToBehavior(
      {required this.figure,
      required this.target,
      required super.minDist,
      required super.maxSpeed,
      required super.maxForce});

  @override
  Vector2 move(double dt) {
    double speed = maxSpeed;
    Vector2 desired = (target - figure.position).normalized() * speed * dt;
    Vector2 steering = (desired - figure.velocity);
    steering.clampScalar(-maxForce, maxForce);
    return steering;
  }
}

class PursueBehavior extends Behavior {
  FigureComponent figure;
  FigureComponent targetFigure;

  PursueBehavior(
      {required this.figure,
      required this.targetFigure,
      required super.minDist,
      required super.maxSpeed,
      required super.maxForce});

  @override
  Vector2 move(double dt) {
    double speed = maxSpeed;
    Vector2 desired =
        (targetFigure.position - figure.position).normalized() * speed * dt;
    Vector2 steering = (desired - figure.velocity);
    steering.clampScalar(-maxForce, maxForce);
    return steering;
  }
}

class EvadeBehavior extends Behavior {
  FigureComponent figure;
  FigureComponent targetFigure;

  EvadeBehavior(
      {required this.figure,
      required this.targetFigure,
      required super.minDist,
      required super.maxSpeed,
      required super.maxForce});

  @override
  Vector2 move(double dt) {
    double speed = maxSpeed;
    Vector2 desired =
        (-targetFigure.position + figure.position).normalized() * speed * dt;
    Vector2 steering = (desired - figure.velocity);
    steering.clampScalar(-maxForce, maxForce);
    return steering;
  }
}
