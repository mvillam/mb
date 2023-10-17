import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:mb/mb_world.dart';
import 'package:mb/utilities/behavior.dart';


class MBGame extends FlameGame with HasKeyboardHandlerComponents {
  MBGame()
  {
    super.camera =CameraComponent();
    super.world = MBWorld();
    images.prefix ='';
  }

  @override
  Future<void> onLoad() async {
    debugMode = false;
  }


}
