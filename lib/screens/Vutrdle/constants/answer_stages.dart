//created by Kateřina Lojdová - xlojdo00
// holds the different stages a letter can go through during the game
enum AnswerStage {
  correct, // correct letter in the correct position
  incorrect, // letter not in the word
  contains, // correct letter in the wrong position
  notAnswered // letter has not yet been used
}
