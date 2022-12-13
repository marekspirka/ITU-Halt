class FocusClass {
  int? inputNumber;
  int? indexBox;
  int? indexChar;
  String? textString;

  setData(int? indexBox, int? indexChar, String? text) {
    this.indexBox = indexBox;
    this.indexChar = indexChar;
    textString = text;
  }
}

class InputClass {
  int index = 0;
  int numberInput = 0;
  bool isInputFocus = false;
  bool isInputAll = false;

  InputClass(this.index, this.numberInput, this.isInputFocus, this.isInputAll);
}

class SettingsClass {
  bool hightlightSameValues = false;
  bool hightlightLines = false;
  bool remainingNumbers = false;
  bool wrongValues = false;
}
