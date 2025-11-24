import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RunnerGame extends FlameGame with TapDetector {
  late SpriteAnimationComponent playerRunner;
  late ParallaxComponent gameBg;
  late double screenWidth = size.x; // Flame game width
  late double screenHeight = size.y; // Flame game height

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    screenWidth = size.x;
    screenHeight = size.y;
    final runnerImg = await images.load('runner2.png');
    final animation = SpriteAnimation.fromFrameData(
      runnerImg,
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.1,
        textureSize: Vector2(108, 285),
      ),
    );
    playerRunner = SpriteAnimationComponent()
      ..animation = animation
      ..size = Vector2(108, 285) * 0.7
      ..position = Vector2(screenWidth * 0.1, screenHeight * 0.5);

    // playerRunner.position = Vector2(screenWidth * 0.1, screenHeight * 0.5);

    gameBg = await loadParallaxComponent(
      [
        ParallaxImageData('game_bg_cartoon.jpg'),
        // ParallaxImageData('tree_bg.png'),
      ],
      fill: LayerFill.height,
      baseVelocity: Vector2(100, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),
    );

    // print(size);

    add(gameBg);
    add(playerRunner);
  }

  @override
  void onTapDown(TapDownInfo info) {
    final jumpHeight = 150.0;

    // Prevent overlapping jumps
    // if (playerRunner.effecte.isNotEmpty) return;

    // Smooth jump up
    playerRunner.add(
      MoveByEffect(
        Vector2(0, -jumpHeight),
        EffectController(duration: 0.8, curve: Curves.easeOut),
      ),
    );

    // Smooth fall down after up
    playerRunner.add(
      MoveByEffect(
        Vector2(0, jumpHeight),
        EffectController(duration: 0.8, startDelay: 0.2, curve: Curves.easeIn),
      ),
    );
  }
}
