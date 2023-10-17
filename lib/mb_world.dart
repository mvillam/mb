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
  Vector2 size =Vector2(0, 0);
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
    size = Vector2(
      map.tileMap.map.width * worldTileSize,
      map.tileMap.map.height * worldTileSize,
    );
    add(map);
    figures = [];

    Vector2 position = Vector2(worldTileSize / 2, worldTileSize / 2);
    Vector2 target_position =
        toWorldPosition(rnd.nextDouble() * 10, rnd.nextDouble() * 10);

    FigureComponent figure_0 =
        FigureComponent.red(position, Vector2.all(worldTileSize));

    FigureComponent figure_1 =
        FigureComponent.blue(target_position, Vector2.all(worldTileSize));

    figure_0.behavior = PursueBehavior(
        figure: figure_0,
        velocity: Vector2(0, 0),
        targetFigure: figure_1,
        maxSpeed: worldTileSize * 4, minDist: worldTileSize*30);

    figure_1.behavior = EvadeBehavior(
        figure: figure_1,
        velocity: Vector2(0, 0),
        targetFigure: figure_0,
        maxSpeed: worldTileSize * 4, minDist: worldTileSize*6);

    add(figure_0);
    add(figure_1);

    figures.add(figure_0);
    figures.add(figure_1);
    game.camera.follow(figures[0]);
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
