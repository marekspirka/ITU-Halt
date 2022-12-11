import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/models/tile_model.dart';
import 'package:flutter/material.dart';

// handles the key data and game logic
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

    // guessed word is correct
    if (guessedWord == correctWord) {
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
      //guessed word not correct
    } else {
      for (int i = 0; i < 5; i++) {
        // check for letters in correct positions
        if (guessedWord[i] == correctWord[i]) {
          notGuessedYet.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }
      //check for letters in wrong positions
      for (int i = 0; i < notGuessedYet.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (notGuessedYet[i] == tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage =
                  AnswerStage.contains;
              //check for all entries already made to keysMap
              final resultKey = keysMap.entries.where((element) =>
                  element.key == tilesEntered[j + (currentRow * 5)].letter);
              //if answerStage is correct, we dont want to change the color back to yellow
              if (resultKey.single.value != AnswerStage.correct) {
                keysMap.update(
                    resultKey.single.key, (value) => AnswerStage.contains);
              }
            }
          }
        }
      }
    }
    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        final resultKey = keysMap.entries
            .where((element) => element.key == tilesEntered[i].letter);
        //if answerStage is incorrect, we dont want to change the color to yellow or green
        if (resultKey.single.value == AnswerStage.notAnswered) {
          keysMap.update(
              tilesEntered[i].letter, (value) => AnswerStage.incorrect);
        }
      }
    }
    currentRow++;
    notifyListeners(); //update listeners once the stage values change
  }
}
