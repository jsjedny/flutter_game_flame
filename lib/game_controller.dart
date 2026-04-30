import 'package:flutter_game_flame/game/runner_game.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  late RunnerGame game;

  @override
  void onInit() {
    super.onInit();
    game = RunnerGame();
  }
}
