import 'dart:ui';

import 'package:flame/components.dart';
import 'package:mb/behaviors/behaviors.dart';
import 'package:mb/components/marker_component.dart';
import 'package:mb/constants.dart';
import 'package:mb/mb_world.dart';

class ElementComponent extends PositionComponent
    with HasWorldReference<MBWorld> {
  Color color;
  List<MarkerComponent> marks = [];
  List<Behavior> behaviors = [];
  double maxVelocity = worldTileSize * 4;
  double maxForce = worldTileSize * 2;
  Vector2 velocity = Vector2(0, 0);

  ElementComponent({super.position, super.size,this.color=const Color.fromRGBO(255, 0, 0, 1)}) {
    anchor = Anchor.topLeft;
    position= Vector2((position.x+1)*worldTileSize,(position.y+1)*worldTileSize);
    MarkerComponent mt = MarkerComponent(
        position:Vector2(0,0),
        size: size,
        type: MarkerType.triangle,color: color);
    marks.addAll([mt]);
    for (MarkerComponent m in marks) {
      add(m);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    double w_2 = worldTileSize/2;
    velocity.x=0;
    velocity.y=0;
    Vector2 acc = Vector2(0, 0);
    for (Behavior b in behaviors) {
      acc.add(b.move(dt));
      lookAt(position+acc);
    }
    acc.clampScalar(-maxForce, maxForce);
    velocity.add(acc);
    velocity.clampScalar(-maxVelocity, maxVelocity);
    position.add(velocity);
    //borders();

    position.clamp(Vector2(w_2,w_2), Vector2(maxWorldSizeX-w_2,maxWorldSizeY-w_2));
  }


  void borders()
  {
    double w_2 = worldTileSize/2;
    if(position.x>maxWorldSizeX-w_2)
      {
        position.x = w_2;
      }
    else if(position.x< w_2)
      {
        position.x =maxWorldSizeX-w_2;
      }
    if(position.y>maxWorldSizeY-w_2)
    {
      position.y = w_2;
    }
    else if(position.y< w_2)
    {
      position.y =maxWorldSizeY-w_2;
    }
  }
  void addBehavior(Behavior b) {
    behaviors.add(b);
  }
}
