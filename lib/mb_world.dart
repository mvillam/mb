import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/src/effects/provider_interfaces.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:mb/behaviors/behaviors.dart';
import 'package:mb/components/element_component.dart';
import 'package:mb/components/path_component.dart';
import 'package:mb/gen/assets.gen.dart';
import 'package:mb/mb_game.dart';

import 'constants.dart';

class MBWorld extends World with HasGameRef<MBGame> {
  late TiledComponent map;
  final Vector2 size = Vector2(
    maxWorldSizeX * worldTileSize,
    maxWorldSizeY * worldTileSize,
  );

  Vector2 toWorldPosition(double x, double y) =>
      Vector2(x  * worldTileSize+worldTileSize/2, y  * worldTileSize +worldTileSize/2);

  MBWorld({super.children});

  @override
  Future<void> onLoad() async {
    final math.Random rnd = math.Random();
    map = await TiledComponent.load(
        Assets.tiles.bmMap, Vector2.all(worldTileSize),
        prefix: '');
    map.priority = 0;
    map.anchor = Anchor.topLeft;
    add(map);


    List<Vector2> points = [];
    points.add(toWorldPosition(20, 20));
    points.add(toWorldPosition(25, 70));
    points.add(toWorldPosition(50, 60));
    points.add(toWorldPosition(75, 90));
    points.add(toWorldPosition(15, 90));
    PathComponent pathComponent = PathComponent(points);
    map.add(pathComponent);

    ElementComponent e_0 = ElementComponent(
        position: Vector2(5, 5),
        size: Vector2(worldTileSize, worldTileSize),color: const Color.fromRGBO(0, 0, 255, 1));
   // e_0.addBehavior(WanderBehavior(e_0,randomSrc:rnd,maxVelocity: worldTileSize*10, wanderAng: math.pi/30,wanderAngVariation: math.pi/36));
    //e_0.addBehavior(GoToBehavior(e_0,maxVelocity:worldTileSize*5,target: toWorldPosition(50, 50)));

    e_0.addBehavior(FollowPathBehavior(e_0,maxVelocity:worldTileSize*5,points: points));
    map.add(e_0);




    /*for (double x = 2; x < 5; x+=5) {
      for (double y = 0; y < 5; y++) {
        ElementComponent e = ElementComponent(
            position: Vector2(x, y),
            size: Vector2(worldTileSize, worldTileSize));
        e.addBehavior(FollowBehavior(e, targetElement: e_0 ,perceptionDist: worldTileSize*50, maxVelocity: worldTileSize* (rnd.nextDouble()*20+5)));

        e_0.addBehavior(EvadeBehavior(e_0, targetElement: e ,perceptionDist: worldTileSize*20, maxVelocity: worldTileSize*5));
        map.add(e);

      }
    }*/

  /*  MarkerComponent m = MarkerComponent(
        position: toWorldPosition(50, 50),
        size: Vector2(worldTileSize, worldTileSize),
        type: MarkerType.rectangle);
    map.add(m);*/


    //game.camera.viewfinder.visibleGameSize = Vector2(100*worldTileSize, 100*worldTileSize);
    game.camera.viewfinder.zoom = 0.25;
   //game.camera.moveTo(toWorldPosition(50, 50));
    game.camera.follow(e_0);
  }

  void setCameraBounds(Vector2 gameSize) {
    game.camera.setBounds(
      Rectangle.fromLTRB(
        gameSize.x,
        gameSize.y,
        size.x - gameSize.x / 2,
        size.y - gameSize.y / 2,
      ),
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    Vector2 view = Vector2(size.x, size.y);
    if (size.x > maxWorldSizeX) {
      view.x = maxWorldSizeX;
    }
    if (size.y > maxWorldSizeY) {
      view.y = maxWorldSizeY;
    }
    setCameraBounds(view);
  }
}
