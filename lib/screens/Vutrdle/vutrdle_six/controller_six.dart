//created by Kateřina Lojdová - xlojdo00
// holds the controller for a 6-letter game
import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/shared_components/stats_box_lost.dart';
import 'package:Halt/screens/Vutrdle/shared_components/stats_box_won.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/data/helper_values.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/stats.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/models/tile_model.dart';

import 'package:flutter/material.dart';

// handles the key data and game logic
class ControllerSix extends ChangeNotifier {
  int currentTile = 0; // current tile within a row
  int currentRow = 0; // current row we are working on
  String correctWord = "";
  List<TileModel> tilesEntered = [];
  bool flipLine = false;
  bool gameWon = false;
  bool gameCompleted = false;
  int currentStreak = 0;
  int maxstreak = 0;

  //method to set the word to be guessed
  setCorrectWord({required String word}) {
    correctWord = word;
    // initialise correct word for helper bar
    helperList = correctWord.split('');
    for (int i = 0; i < helperList.length; i++) {
      helperMap[helperList[i]] = HelperStage.notguessed;
    }
    notifyListeners();
  }

  //method that handles individually tapped keys
  setKeyTapped({required String value, required BuildContext context}) {
    if (value == 'ENTER') {
      // enter key
      if (currentTile == 6 * (currentRow + 1)) {
        checkWord(context: context);
      }
    } else if (value == 'BACK') {
      // back key
      if (currentTile > 6 * (currentRow + 1) - 6) {
        tilesEntered
            .removeLast(); // removes the last entry from letters entered
        currentTile--;
      }
    } else {
      //any other key on the keyboard
      if (currentTile < 6 * (currentRow + 1)) {
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
  checkWord({required BuildContext context}) {
    // create new empty lists every time this method runs
    // holds the letters user has put in
    List<String> guessedLetters = [];
    // holds the letters that have not been guessed yet
    List<String> notGuessedYet = [];
    String guessedWord = "";
    for (int i = currentRow * 6; i < (currentRow * 6) + 6; i++) {
      guessedLetters.add(tilesEntered[i].letter);
    }

    //initialise lists
    guessedWord = guessedLetters.join();
    notGuessedYet = correctWord.characters.toList();

    // guessed word is correct
    if (guessedWord == correctWord) {
      for (int i = currentRow * 6; i < (currentRow * 6) + 6; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
      showDialog(context: context, builder: (_) => const StatsBoxWon());
      gameWon = true;
      gameCompleted = true;
      //guessed word not correct
    } else {
      for (int i = 0; i < 6; i++) {
        // check for letters in correct positions
        if (guessedWord[i] == correctWord[i]) {
          notGuessedYet.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 6)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
          helperMap.update(guessedWord[i], (value) => HelperStage.guessed);
        }
      }
      //check for letters in wrong positions
      for (int i = 0; i < notGuessedYet.length; i++) {
        for (int j = 0; j < 6; j++) {
          if (notGuessedYet[i] == tilesEntered[j + (currentRow * 6)].letter) {
            if (tilesEntered[j + (currentRow * 6)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 6)].answerStage =
                  AnswerStage.contains;
              //check for all entries already made to keysMap
              final resultKey = keysMap.entries.where((element) =>
                  element.key == tilesEntered[j + (currentRow * 6)].letter);
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
    for (int i = currentRow * 6; i < (currentRow * 6) + 6; i++) {
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
    flipLine = true;
    if (currentRow == 6) {
      gameCompleted = true;
      showDialog(context: context, builder: (_) => const StatsBoxLost());
    }

    //compute streaks
    if (gameCompleted) {
      if (gameWon) {
        results.update('currentStreak', (value) => ++value);
      } else {
        results.update('currentStreak', (value) => 0);
      }
      if (results['currentStreak']! > results['maxStreak']!) {
        results['maxStreak'] = results['currentStreak']!;
      }
      // results.update('currentStreak', (value) => value++);
      // results.update('maxStreak', (value) => value++);
    }
    notifyListeners(); //update listeners once the stage values change
  }
}
