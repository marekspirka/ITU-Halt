class BlokItem {
  String? text; // number + "" (null)
  String? correctText; // correct number
  int? index;
  bool smallNumber = false;
  bool isFocus = false; // highlight one item
  bool isFocusCross = false; // highlight cross
  bool isFocusNumber = false; // highlight same numbers
  bool isWrong = false; // number is wrong
  bool isCorrect; // number is correct
  bool isDefault; // generate number
  bool isExist = false;

  BlokItem(
    this.text, {
    this.index,
    this.isDefault = false,
    this.correctText,
    this.isCorrect = false,
  });

  // declare method used
  get isCorrectPos => correctText == text;
  setText(String text) {
    this.text = text;
    isCorrect = isCorrectPos;
  }

  setEmpty() {
    text = "";
    isCorrect = false;
  }
}
