//created by Kateřina Lojdová - xlojdo00
// holds the tile model for a 6-letter game
import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';

class TileModel {
  final String letter;
  AnswerStage answerStage;

  TileModel(
      {required this.letter, required this.answerStage}); //class constructor
}
