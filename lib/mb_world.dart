import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:mb/components/figure_component.dart';
import 'package:mb/gen/assets.gen.dart';
import 'package:mb/mb_game.dart';
import 'package:mb/utilities/behavior.dart';

import 'constants.dart';

class MBWorld extends World with HasGameRef<MBGame>, HasCollisionDetection {
  late TiledComponent map;
  Vector2 size = Vector2(0, 0);
  List<FigureComponent> figures = [];

  Vector2 toWorldPosition(double x, double y) => Vector2(
      x * worldTileSize + worldTileSize / 2,
      y * worldTileSize + worldTileSize / 2);

  MBWorld({super.children});

  @override
  Future<void> onLoad() async {
    final Random rnd = Random();
    map = await TiledComponent.load(
        Assets.tiles.bmMap, Vector2.all(worldTileSize),
        prefix: '');
    map.priority = 0;
    map.anchor = Anchor.topLeft;
    size = Vector2(
      map.tileMap.map.width * worldTileSize,
      map.tileMap.map.height * worldTileSize,
    );
    add(map);
    figures = [];

    Vector2 position_0 =
        toWorldPosition(rnd.nextDouble() * 50,rnd.nextDouble() * 50);
    FigureComponent figure_0 =
        FigureComponent.red(position_0, Vector2.all(worldTileSize));
    figure_0.maxForce =1;
    figure_0.maxVelocity =worldTileSize*8;
    figure_0.createGoToCenterBehavior(worldTileSize*10,worldTileSize*10);
    add(figure_0);
    figures.add(figure_0);


    for (int i = 0; i < 100; i++) {
      Vector2 position_i =
          toWorldPosition(rnd.nextDouble() * 100, rnd.nextDouble() * 100);
      FigureComponent figure_i =
          FigureComponent.blue(position_i, Vector2.all(worldTileSize));

      PursueBehavior pb_i_0 = PursueBehavior(
          figure: figure_i,
          targetFigure: figure_0,
          maxSpeed: worldTileSize * (Random().nextDouble() * 10 + 1),
          minDist: worldTileSize * 20,
         maxForce: 0.5);

     /* EvadeBehavior eb_0_i = EvadeBehavior(
          figure: figure_0,
          targetFigure: figure_i,
          maxSpeed: worldTileSize * (Random().nextDouble() * 10 + 1),
          minDist: worldTileSize * 20, maxForce: 100,
          );

      figure_0.behaviors.add(eb_0_i);*/
      figure_i.behaviors.add(pb_i_0);
      add(figure_i);
      figures.add(figure_i);
    }

    game.camera.viewfinder.zoom =0.25;
    game.camera.moveTo(Vector2(maxWorldSizeX / 2, maxWorldSizeY / 2));
    //game.camera.follow(figures[0]);
  }

  void setCameraBounds(Vector2 gameSize) {
    game.camera.setBounds(
      Rectangle.fromLTRB(
        gameSize.x / 2,
        gameSize.y / 2,
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
