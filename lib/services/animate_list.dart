import 'package:flutter/material.dart';

import 'animate_widgets.dart';

class AnimateList {
  AnimateList({
    this.scrollImageController,
    this.scrollTextController,
    this.selectedIndex,
    this.previousSelectedIndex,
    this.isFromImage,
    this.isFromText,
  });

  final ScrollController scrollTextController;
  final ScrollController scrollImageController;

  bool isFromImage;
  bool isFromText;
  int selectedIndex;
  int previousSelectedIndex;

  Future<void> animateList(
      int ind, double width, bool fromText, bool fromImage) async {
    var _animateImage =
        AnimateImage(scrollImageController: scrollImageController);
    var _animateText = AnimateText(scrollTextController: scrollTextController);

    ///
    ///if [Text] i.e Path is tapped
    ///

    if (fromText && !fromImage) {
      if (ind > selectedIndex) {
        print(
            "RAN FROM TEXT FORWARD selected index: $selectedIndex and ind : $ind");
        await _animateText.animateForward(ind, width, selectedIndex);
        await _animateImage.animateForward(ind, width, selectedIndex);
        selectedIndex = ind;
        print(
            "RAN FROM TEXT FORWARD UPDATEDD selected index: $selectedIndex and ind : $ind");
      } else if (ind < selectedIndex) {
        print(
            "RAN FROM TEXT BACKWARD  selected index: $selectedIndex and ind : $ind");

        await _animateText.animateBackward(ind, width, selectedIndex);
        await _animateImage.animateBackward(ind, width, selectedIndex);
        selectedIndex = ind;
        print(
            "RAN FROM TEXT BACKWARD UPDATEDD  selected index: $selectedIndex and ind : $ind");
      }
      //

      print("isFromText from the TEXT BLOC: $isFromText ");
      isFromImage = false;
      isFromText = false;
      // selectedIndex = ind;
      print("selected value : $selectedIndex");
      print("isFromText from the TEXT BLOC   UPDATED: $isFromText ");
    }

    ///When [Image] is scrolled
    ///
    else if (fromImage && !fromText) {
      // print(
      //     "ind is :$ind , isFromText is :$isFromText, selectedIndex: $selectedIndex, previous: $previousSelectedIndex");
      if (previousSelectedIndex < selectedIndex) {
        print("RAN from IMAGE FORWARD");

        // print(
        //     "selected index : $selectedIndex , previous: $previousSelectedIndex, FORWARD ANIMATION");
        await _animateText.animateForward(
            selectedIndex, width, previousSelectedIndex);
        await _animateImage.animateForward(
            previousSelectedIndex, width, selectedIndex);

        //

      } else if (previousSelectedIndex > selectedIndex) {
        print("RAN from IMAGE BACKWARD");
        await _animateText.animateBackward(
            selectedIndex, width, previousSelectedIndex);
        await _animateImage.animateBackward(
            previousSelectedIndex, width, selectedIndex);

        // selectedIndex = previousSelectedIndex;

        //   print(
        //       "selected index : $selectedIndex , previous: $previousSelectedIndex, BACKWARD ANIMATION");
      }
      isFromText = false;
      isFromImage = false;
    } else
      return;
  }
}
