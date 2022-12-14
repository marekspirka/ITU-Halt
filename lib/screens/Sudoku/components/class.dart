// created by Andrea Michlíková - xmichl11
// holds classes - used in sudoku

// holds class - for highlight and set BlokItem
class FocusClass {
  int? inputNumber;
  int? indexBox;
  int? indexChar;
  String? textString;

  // declare method used
  setData(int? indexBox, int? indexChar, String? text) {
    this.indexBox = indexBox;
    this.indexChar = indexChar;
    textString = text;
  }
}

// holds class - for highlight and set BlokItem with "keaboard"
class InputClass {
  int index = 0;
  int numberInput = 0;
  bool isInputFocus = false;
  bool isInputAll = false;

  InputClass(this.index, this.numberInput, this.isInputFocus, this.isInputAll);
}
