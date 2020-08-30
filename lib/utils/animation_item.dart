import 'package:flutter/material.dart';

typedef AnimationCallBack = void Function(AnimationItem animation);

class AnimationItem {
  final String name;
  final Tween<double> tween;

  AnimationItem({this.name, this.tween});
}

Tween findAnimation(String name, double initValue, List<AnimationItem> list) {
  try {
    if (list.length > 0) {
      var tween = list.where((element) => element.name == name);
      return tween == null
          ? Tween<double>(begin: initValue, end: initValue)
          : tween.first.tween;
    } else {
      return Tween<double>(begin: initValue, end: initValue);
    }
  } catch (e) {
    return Tween<double>(begin: initValue, end: initValue);
  }
}

Future<void> delayAnimation(AnimationItem animation, Duration duration,
    AnimationCallBack function) async {
  await Future.delayed(duration, () {});
  function(animation);
}

// Tween delayWidgetAnimation(Duration delayDuration, double initCValue) {}
