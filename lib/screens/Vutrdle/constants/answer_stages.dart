enum AnswerStage {
  correct, // correct letter in the correct position
  incorrect, // letter not in the word
  contains, // correct letter in the wrong position
  notAnswered // letter has not yet been used
}
