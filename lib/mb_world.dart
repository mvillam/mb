import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:mb/behaviors/behaviors.dart';
import 'package:mb/components/element_component.dart';
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
      Vector2((x + 1) * worldTileSize / 2, (y + 1) * worldTileSize / 2);

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

    ElementComponent e_0 = ElementComponent(
        position: Vector2(50, 50),
        size: Vector2(worldTileSize, worldTileSize),color: const Color.fromRGBO(0, 0, 255, 1));
    e_0.addBehavior(WanderBehavior(e_0,randomSrc:rnd,maxVelocity: worldTileSize*5, wanderAng: math.pi/30,wanderAngVariation: math.pi/36));
    map.add(e_0);
/*
    for (double x = 2; x < 10; x+=5) {
      for (double y = 0; y < 10; y++) {
        ElementComponent e = ElementComponent(
            position: Vector2(x, y),
            size: Vector2(worldTileSize, worldTileSize));
        e.addBehavior(FollowBehavior(e, targetElement: e_0 ,perceptionDist: worldTileSize*50, maxVelocity: worldTileSize* (rnd.nextDouble()*20+5)));

        e_0.addBehavior(EvadeBehavior(e_0, targetElement: e ,perceptionDist: worldTileSize*20, maxVelocity: worldTileSize*5));
        map.add(e);

      }
    }
*/
  /*  MarkerComponent m = MarkerComponent(
        position: toWorldPosition(50, 50),
        size: Vector2(worldTileSize, worldTileSize),
        type: MarkerType.rectangle);
    map.add(m);*/



    game.camera.viewfinder.zoom = 0.25;
    game.camera.moveTo(toWorldPosition(50, 50));
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
