import 'package:flutter/material.dart';

abstract class AnimateWidgets {
  void animateForward(int currentIndex, double width, int selectedIndex);
  void animateBackward(int currentIndex, double width, int selectedIndex);
}

class AnimateImage implements AnimateWidgets {
  AnimateImage({this.scrollImageController});

  final ScrollController scrollImageController;

  @override
  void animateBackward(int currentIndex, double width, int selectedIndex) {
    scrollImageController.animateTo(
      currentIndex == 0 ? width * currentIndex : width,
      duration: Duration(milliseconds: 1500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void animateForward(int currentIndex, double width, int selectedIndex) {
    scrollImageController.animateTo(
      currentIndex == 0 ? width : width * currentIndex,
      duration: Duration(milliseconds: 1500),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class AnimateText implements AnimateWidgets {
  AnimateText({this.scrollTextController});
  final ScrollController scrollTextController;

  @override
  void animateBackward(int currentIndex, double width, int selectedIndex) {
    scrollTextController.animateTo(
      currentIndex == 0 ? width * .30 : 0.0,
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void animateForward(int currentIndex, double width, int selectedIndex) {
    num currentOffset = scrollTextController.offset;
    num indexDiff = currentIndex - selectedIndex;
    if (indexDiff < 2) {
      print(currentIndex - selectedIndex);
      currentOffset += width / 2 * (currentIndex - selectedIndex);
    } else if (indexDiff > 2 && indexDiff < 4) {
      print(currentIndex - selectedIndex);
      currentOffset += (width / 4) * indexDiff;
    } else {
      print(currentIndex - selectedIndex);

      currentOffset = currentOffset + width / 2;
    }

    scrollTextController.animateTo(
      currentOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.linear,
    );
  }
}
