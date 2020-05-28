import 'package:flutter/material.dart';

abstract class AnimateWidgets {
  Future<void> animateForward(
      int currentIndex, double width, int selectedIndex);
  Future<void> animateBackward(
      int currentIndex, double width, int selectedIndex);
}

class AnimateImage implements AnimateWidgets {
  AnimateImage({this.scrollImageController});

  final ScrollController scrollImageController;

  @override
  Future<void> animateBackward(
      int currentIndex, double width, int selectedIndex) async{
   await  scrollImageController.animateTo(
      currentIndex == 0 ? width * currentIndex : width,
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Future<void> animateForward(
      int currentIndex, double width, int selectedIndex) async{
   await scrollImageController.animateTo(
      currentIndex == 0 ? width : width * currentIndex,
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class AnimateText implements AnimateWidgets {
  AnimateText({this.scrollTextController});
  final ScrollController scrollTextController;

  bool isFinished = false;

  @override
  Future<void> animateBackward(
      int currentIndex, double width, int selectedIndex) async {
    await scrollTextController.animateTo(
      currentIndex == 0 ? width * .30 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Future<void> animateForward(
      int currentIndex, double width, int selectedIndex) async {
    num currentOffset = scrollTextController.offset;
    num indexDiff = currentIndex - selectedIndex;
    if (indexDiff < 2) {
      // print(currentIndex - selectedIndex);
      currentOffset += width / 2 * (currentIndex - selectedIndex);
    } else if (indexDiff > 2 && indexDiff < 4) {
      // print(currentIndex - selectedIndex);
      currentOffset += (width / 4) * indexDiff;
    } else {
      // print(currentIndex - selectedIndex);

      currentOffset = currentOffset + width / 2;
    }

   await scrollTextController.animateTo(
      currentOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
