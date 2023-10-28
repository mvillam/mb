import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:mb/components/element_component.dart';
import 'package:mb/constants.dart';
import 'package:mb/utilities/utilities.dart';

class Behavior with Utilities{
  ElementComponent element;
  Behavior(this.element);


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
      desired = (target - element.position).normalized() * speed*dt;
    }
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
        desired = (-targetElement.position + element.position).normalized() * speed*dt;
    }
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
        desired = (targetElement.position- element.position).normalized() * speed*dt;
      }
    } else {
      desired = (targetElement.position - element.position).normalized() * speed*dt;
    }
    Vector2 steering = (desired - element.velocity);
    return steering;
  }
}

class WanderBehavior extends Behavior with Utilities{
  double maxVelocity;
  double wanderAng;
  double wanderAngVariation;
  double wanderRadius;
      math.Random randomSrc;
  double wanderPointCenterDist;

  WanderBehavior(super.element,{required this.randomSrc , required this.maxVelocity,this.wanderRadius =10*worldTileSize,this.wanderPointCenterDist=2 *worldTileSize,this.wanderAng=0,this.wanderAngVariation =0.3});

  @override
  Vector2 move(double dt) {
    double speed = maxVelocity;

    wanderAng +=doubleInRange(randomSrc,-wanderAngVariation,wanderAngVariation);

    Vector2 wanderPoint = element.velocity.clone();
    wanderPoint.scaleTo(wanderPointCenterDist);
    wanderPoint.add(element.position);

    double x =wanderRadius *math.cos(wanderAng);
    double y =wanderRadius *math.sin(wanderAng);

    wanderPoint.add(Vector2(x, y));
    Vector2 steering = (wanderPoint-element.position).normalized()*speed*dt;
    return steering;
  }

}