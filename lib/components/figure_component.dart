import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:mb/constants.dart';
import 'package:mb/mb_world.dart';


import '../utilities/behavior.dart';
import 'marker_component.dart';

class FigureComponent extends PositionComponent
    with HasWorldReference<MBWorld> {
  Color color;

  double mass=1;
  double maxForce = 0.2;
  double maxVelocity = worldTileSize *1;
  Vector2 velocity = Vector2(0, 0);
  Vector2 acceleration = Vector2(0, 0);
  late List<Behavior> behaviors =[];
  late MarkerComponent box;

  FigureComponent(
      {required Vector2 position,
      required Vector2 size,
      required this.color,
      required List<Behavior> behaviors})
      : super(position: position) {
    anchor = Anchor.center;
    box = MarkerComponent(Vector2(0, 0), size, color);
    this.behaviors.addAll(behaviors);
  }

  factory FigureComponent.red(Vector2 position, Vector2 size) =>
      FigureComponent(
          position: position,
          size: size,
          color: const Color.fromARGB(255, 255, 0, 0),
          behaviors: [Behavior()]);

  factory FigureComponent.green(Vector2 position, Vector2 size) =>
      FigureComponent(
          position: position,
          size: size,
          color: const Color.fromARGB(255, 0, 255, 0),
          behaviors: [Behavior()]);

  factory FigureComponent.blue(Vector2 position, Vector2 size) =>
      FigureComponent(
          position: position,
          size: size,
          color: const Color.fromARGB(255, 0, 0, 255),
          behaviors: [Behavior()]);

  @override
  void onLoad() {
    box.anchor = Anchor.center;
    add(box);
  }

  void createGoToCenterBehavior(double minDist,double maxVelocity) {
    Vector2 center = Vector2(maxWorldSizeX/2,maxWorldSizeY/2);
    behaviors.add(GoToBehavior(
      figure: this,
      target: center,
      maxSpeed: maxVelocity, minDist: minDist, maxForce: 100000,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateMove(dt);
  }

  void updateMove(double dt) {
    double w_2 = worldTileSize/2;

    Vector2 vel = Vector2(0, 0);
    Vector2 acc = Vector2(0, 0);

  //  int l =behaviors.length;
    double mf =maxForce;


    for(Behavior b in behaviors) {
      acc.add(b.move(dt));
    }
    acc.clampScalar(-mf, mf);
    vel.add(acc);
    vel.clampScalar(-maxVelocity, maxVelocity);
    position.add(vel);
    lookAt(position+vel);
    position.clamp(Vector2(w_2,w_2), Vector2(maxWorldSizeX-w_2,maxWorldSizeY-w_2));



  }
}
