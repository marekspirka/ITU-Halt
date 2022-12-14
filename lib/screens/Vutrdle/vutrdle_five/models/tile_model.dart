//created by Kateřina Lojdová - xlojdo00
// holds the model of one tile for a 5-letter game
import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';

class TileModel {
  final String letter;
  AnswerStage answerStage;

  TileModel(
      {required this.letter, required this.answerStage}); //class constructor
}
