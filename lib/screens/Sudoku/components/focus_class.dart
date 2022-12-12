class FocusClass {
  int? indexBox;
  int? indexChar;
  String? textString;

  setData(int? indexBox, int? indexChar, String? text) {
    this.indexBox = indexBox;
    this.indexChar = indexChar;
    textString = text;
  }

  // focusOn(int indexBox, int indexChar) {
  //   return this.indexBox == indexBox && this.indexChar == indexChar;
  // }
}
