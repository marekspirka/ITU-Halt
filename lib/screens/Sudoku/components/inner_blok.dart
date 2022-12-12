import 'package:Halt/screens/Sudoku/components/blok_item.dart';

class InnerBlok {
  late int index;
  List<BlokItem> blokItem = List<BlokItem>.from([]);

  InnerBlok(this.index, this.blokItem);

  // declare method used
  setFocus(String text, int index, Direction direction) {
    List<BlokItem> temp;

    if (direction == Direction.horizontal) {
      temp = blokItem
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else if (direction == Direction.vertical) {
      temp =
          blokItem.where((element) => element.index! % 3 == index % 3).toList();
    } else {
      //temp =
      //  blokItem.where((element) => element.correctText == text).toList();
      temp = blokItem.where((element) => element.text == text).toList();
    }

    for (var element in temp) {
      if (direction == Direction.all) {
        element.isFocusNumber = true;
      } else {
        element.isFocusCross = true;
      }
    }
  }

  setExistValue(
      int index, int indexBox, String textInput, Direction direction) {
    List<BlokItem> temp;

    if (direction == Direction.horizontal) {
      temp = blokItem
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp =
          blokItem.where((element) => element.index! % 3 == index % 3).toList();
    }

    if (this.index == indexBox) {
      List<BlokItem> blokItemBox =
          blokItem.where((element) => element.text == textInput).toList();

      if (blokItemBox.length == 1 && temp.isEmpty) blokItemBox.clear();

      temp.addAll(blokItemBox);
    }

    temp.where((element) => element.text == textInput).forEach((element) {
      element.isExist = true;
    });
  }

  clearFocus() {
    for (var element in blokItem) {
      element.isFocusCross = false;
      element.isFocusNumber = false;
    }
  }

  clearExist() {
    for (var element in blokItem) {
      element.isExist = false;
    }
  }
}

enum Direction { horizontal, vertical, all }
