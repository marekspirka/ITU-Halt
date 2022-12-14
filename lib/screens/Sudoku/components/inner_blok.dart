// created by Andrea Michlíková - xmichl11
// holds class InnerBlok - info about one big square
import 'package:Halt/screens/Sudoku/components/blok_item.dart';

class InnerBlok {
  late int index;
  List<BlokItem> blokItem = List<BlokItem>.from([]);

  InnerBlok(this.index, this.blokItem);

  // declare method used
  // set highlight
  setFocus(String text, int index, Direction direction) {
    List<BlokItem> temp;

    // pick horizontal number
    if (direction == Direction.horizontal) {
      temp = blokItem
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
      // pick vertical number
    } else if (direction == Direction.vertical) {
      temp =
          blokItem.where((element) => element.index! % 3 == index % 3).toList();
      // pick same nubers number
    } else {
      temp = blokItem.where((element) => element.text == text).toList();
    }

    // set highlight on
    for (var element in temp) {
      if (direction == Direction.all) {
        element.isFocusNumber = true;
      } else {
        element.isFocusCross = true;
      }
    }
  }

  // set error highlight
  setExistValue(
      int index, int indexBox, String textInput, Direction direction) {
    List<BlokItem> temp;

    // pick horizontal number
    if (direction == Direction.horizontal) {
      temp = blokItem
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
      // pick vertical number
    } else {
      temp =
          blokItem.where((element) => element.index! % 3 == index % 3).toList();
    }

    // pick same number
    if (this.index == indexBox) {
      List<BlokItem> blokItemBox =
          blokItem.where((element) => element.text == textInput).toList();
      if (blokItemBox.length == 1 && temp.isEmpty) blokItemBox.clear();
      temp.addAll(blokItemBox);
    }

    // set Exist on
    temp.where((element) => element.text == textInput).forEach((element) {
      element.isExist = true;
    });
  }

  // set table to original state
  clearNotDefault() {
    for (var element in blokItem) {
      if (!element.isDefault) {
        element.isCorrect = false;
        element.text = "";
        element.correctText = "";
      }
    }
  }

  // set Focus off
  clearFocus() {
    for (var element in blokItem) {
      element.isFocus = false;
      element.isFocusCross = false;
      element.isFocusNumber = false;
    }
  }

  // set Exist off
  clearExist() {
    for (var element in blokItem) {
      element.isExist = false;
    }
  }
}

enum Direction { horizontal, vertical, all }
