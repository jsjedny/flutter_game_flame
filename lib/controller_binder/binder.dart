import 'package:flutter_game_flame/game_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController(), fenix: true);
  }
}
