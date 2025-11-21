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

    gameBg = await loadParallaxComponent(
      [
        ParallaxImageData('game_bg_cartoon.jpg'),
        // ParallaxImageData('tree_bg.png'),
      ],
      baseVelocity: Vector2(100, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),
    );

    

    add(gameBg);
    add(playerRunner);
  }

  @override
  void onTapDown(TapDownInfo info) {
    final jumpHeight = 100.0;

    // Prevent overlapping jumps
    // if (playerRunner.effecte.isNotEmpty) return;

    // Smooth jump up
    playerRunner.add(
      MoveByEffect(
        Vector2(0, -jumpHeight),
        EffectController(duration: 0.2, curve: Curves.easeOut),
      ),
    );

    // Smooth fall down after up
    playerRunner.add(
      MoveByEffect(
        Vector2(0, jumpHeight),
        EffectController(duration: 0.3, startDelay: 0.2, curve: Curves.easeIn),
      ),
    );
  }

  // @override
  // void onTapDown(TapDownInfo info) {
  //   final originalY = size.y * 0.6;

  //   playerRunner.position.y = originalY - 50;
  //   Future.delayed(Duration(milliseconds: 250), () {
  //     playerRunner.position.y = originalY;
  //   });
  // }
}

// import 'dart:async';
// import 'package:flame/events.dart';
// import 'package:flame/input.dart';
// import 'package:flame/parallax.dart';
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';

// class RunnerGame extends FlameGame with TapDetector {
//   late SpriteAnimationComponent playerRunner;
//   bool isJumping = false;
//   double jumpHeight = 50.0;
//   double jumpDuration = 0.1; // seconds
//   double jumpTime = 0.0;
//   late double originalY;

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     originalY = size.y * 0.6;

//     // Player load
//     final runnerImg = await images.load('runner2.png');
//     final animation = SpriteAnimation.fromFrameData(
//       runnerImg,
//       SpriteAnimationData.sequenced(
//         amount: 8,
//         stepTime: 0.1,
//         textureSize: Vector2(108, 285),
//       ),
//     );
//     playerRunner = SpriteAnimationComponent()
//       ..animation = animation
//       ..size = Vector2(108, 285) * 0.7
//       ..position = Vector2(size.x * 0.1, originalY);
//     add(playerRunner);
//   }

//   @override
//   void onTapDown(TapDownInfo info) {
//     if (!isJumping) {
//       isJumping = true;
//       jumpTime = 0.1;
//       playerRunner.position.y = originalY - jumpHeight; // jump up
//     }
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);

//     if (isJumping) {
//       jumpTime += dt;
//       if (jumpTime >= jumpDuration) {
//         playerRunner.position.y = originalY; // back to original
//         isJumping = false;
//       }
//     }
//   }
// }
