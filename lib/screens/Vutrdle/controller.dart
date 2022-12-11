import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/models/tile_model.dart';
import 'package:flutter/material.dart';
import './data/keys_map.dart';

// handles the key data
class Controller extends ChangeNotifier {
  int currentTile = 0; // current tile within a row
  int currentRow = 0; // current row we are working on
  String correctWord = "";
  List<TileModel> tilesEntered = [];

  //method to set the word to be guessed
  setCorrectWord({required String word}) {
    correctWord = word;
  }

  //method that handles individually tapped keys
  setKeyTapped({required String value}) {
    if (value == 'ENTER') {
      // enter key
      if (currentTile == 5 * (currentRow + 1)) {
        checkWord();
      }
    } else if (value == 'BACK') {
      // back key
      if (currentTile > 5 * (currentRow + 1) - 5) {
        tilesEntered
            .removeLast(); // removes the last entry from letters entered
        currentTile--;
      }
    } else {
      //any other key on the keyboard
      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(TileModel(
            letter: value,
            answerStage: AnswerStage
                .notAnswered)); // set initial state when pressing a key
        currentTile++;
      }
    }
    notifyListeners(); // update dependencies based on what was typed into the keyboard
  }

  // method to check if the guessed word is correct
  checkWord() {
    // create new empty lists every time this method runs
    // holds the letters user has put in
    List<String> guessedLetters = [];
    // holds the letters that have not been guessed yet
    List<String> notGuessedYet = [];
    String guessedWord = "";
    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessedLetters.add(tilesEntered[i].letter);
    }

    //initialise lists
    guessedWord = guessedLetters.join();
    notGuessedYet = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      print('word guessed correct <3');
    } else {
      for (int i = 0; i < 5; i++) {
        // check for letters in correct positions
        if (guessedWord[i] == correctWord[i]) {
          notGuessedYet.remove(guessedWord[i]);
          print('correct letter ${guessedWord[i]}');
        }
      }
      //check for letters in wrong positions
      for (int i = 0; i < notGuessedYet.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (notGuessedYet[i] == tilesEntered[j + (currentRow * 5)].letter) {
            print('contains ${notGuessedYet[i]}');
          }
        }
      }
    }
    currentRow++;
  }
}
