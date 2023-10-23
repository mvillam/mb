import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:mb/components/element_component.dart';
import 'package:mb/constants.dart';

class Behavior {
  ElementComponent element;
  Behavior(this.element);
  mapRange(a1, a2, b1, b2, s) => (b1 + (s - a1) * (b2 - b1) / (a2 - a1));

  Vector2 move(double dt) {
    return Vector2(0, 0);
  }
}

class GoToBehavior extends Behavior {
  Vector2 target;
  double maxVelocity;
  double perceptionDist;

  GoToBehavior(super.element,
      {required this.target,
      required this.maxVelocity,
      this.perceptionDist = worldTileSize * 10});

  @override
  Vector2 move(double dt) {
    double speed = maxVelocity;
    double dist = target.distanceTo(element.position);
    Vector2 desired = Vector2(0, 0);
    if (dist < perceptionDist) {
      if (dist > 0.05) {
        speed = mapRange(perceptionDist, 0, maxVelocity, 0, dist);
        desired = (target - element.position).normalized() * speed;
      }
    } else {
      desired = (target - element.position).normalized() * speed;
    }

    element.lookAt(target);
    Vector2 steering = (desired - element.velocity);
    return steering;
  }
}


class EvadeBehavior extends Behavior {
  late ElementComponent targetElement;
  double maxVelocity;
  double perceptionDist;

  EvadeBehavior(super.element,
      {required this.targetElement,
        required this.maxVelocity,
        this.perceptionDist = worldTileSize * 10});

  @override
  Vector2 move(double dt) {
    double speed = maxVelocity;
    double dist = targetElement.position.distanceTo(element.position);
    Vector2 desired = Vector2(0, 0);
    if (dist < perceptionDist) {
        speed = mapRange(perceptionDist, 0,0 , maxVelocity, dist);
        desired = (-targetElement.position + element.position).normalized() * speed;
    }
    element.lookAt(targetElement.position);
    element.angle +=math.pi;
    Vector2 steering = (desired - element.velocity);
    return steering;
  }
}

class FollowBehavior extends Behavior {
  late ElementComponent targetElement;
  double maxVelocity;
  double perceptionDist;

  FollowBehavior(super.element,
      {required this.targetElement,
        required this.maxVelocity,
        this.perceptionDist = worldTileSize * 10});

  @override
  Vector2 move(double dt) {
    double speed = maxVelocity;
    double dist = targetElement.position.distanceTo(element.position);
    Vector2 desired = Vector2(0, 0);
    if (dist < perceptionDist) {
      if (dist > 0.05) {
        speed = mapRange(perceptionDist, 0, maxVelocity, 0, dist);
        desired = (targetElement.position- element.position).normalized() * speed;
      }
    } else {
      desired = (targetElement.position - element.position).normalized() * speed;
    }
    element.lookAt(targetElement.position);
    Vector2 steering = (desired - element.velocity);
    return steering;
  }
}
