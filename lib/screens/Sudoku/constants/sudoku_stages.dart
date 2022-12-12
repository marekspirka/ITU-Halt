enum SudokuStage {
  correct, // correct number in the correct position
  incorrect, // number is already in the horizontal/vertical line or in the inner blok

  focusDefaultNumber, //
  focusNotDefaultNumber, //
  focusWriteNumber, //
}
