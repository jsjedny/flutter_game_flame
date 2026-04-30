import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RunnerGame extends FlameGame with TapCallbacks {
  late SpriteAnimationComponent playerRunner;
  late ParallaxComponent gameBg;
  // late ParallaxComponent gameBg2;
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
    final runnerScale = screenWidth * 0.0007;
    // playerRunner.size = Vector2(108, 285) * runnerScale;

    playerRunner = SpriteAnimationComponent()
      ..animation = animation
      ..size = Vector2(108, 285) * runnerScale
      ..position = Vector2(screenWidth * 0.1, screenHeight * 0.6);

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
    // gameBg2 = await loadParallaxComponent(
    //   [
    //     // ParallaxImageData('game_bg_cartoon.jpg'),
    //     ParallaxImageData('tree_bg.png'),
    //   ],
    //   fill: LayerFill.none,
    //   baseVelocity: Vector2(150, 0),
    //   velocityMultiplierDelta: Vector2(1.5, 0),
    //   position: Vector2(screenWidth * 0.1, screenHeight * 0.5),
    // );

    // final scaleFactor = size.x / 1000;
    // gameBg2.scale = Vector2(scaleFactor, scaleFactor);

    // print(size);

    add(gameBg);
    // add(gameBg2);
    add(playerRunner);
  }

  bool isJumping = false; // jump flag

  @override
  void onTapDown(TapDownEvent event) {
    if (isJumping) return; // block double tap

    isJumping = true;
    doJump();
  }

  void doJump() {
    final jumpHeight = 150.0;

    // Jump Up
    final jumpUp = MoveByEffect(
      Vector2(0, -jumpHeight),
      EffectController(duration: 0.4, curve: Curves.easeOut),
    );

    // Jump Down
    final jumpDown = MoveByEffect(
      Vector2(0, jumpHeight),
      EffectController(duration: 0.4, startDelay: 0.4, curve: Curves.easeIn),
    );

    // Jump finished callback
    jumpDown.onComplete = () {
      isJumping = false;
    };

    // Add effects to player
    playerRunner.add(jumpUp);
    playerRunner.add(jumpDown);
  }
}
