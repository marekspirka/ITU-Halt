import 'package:Halt/screens/Sudoku/NavBar_sudoku.dart';
import 'package:Halt/screens/Sudoku/Sudoku_help.dart';
import 'package:flutter/material.dart';

class SudokuScreen extends StatelessWidget {
  const SudokuScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarSudoku(),
      endDrawer: NavBarSudokuHelp(),
      appBar: AppBar(
        actions: [
          Builder(
              builder: (context) => // Ensure Scaffold is in context
                  IconButton(
                      icon: const Icon(Icons.question_mark_outlined),
                      onPressed: () => Scaffold.of(context).openEndDrawer())),
        ],
        title: const Text('Halt.'),
        titleTextStyle: const TextStyle(fontSize: 35),
        centerTitle: true,
        backgroundColor: const Color(0xff270e17),
        elevation: 2,
        toolbarHeight: 60,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4E1C2E),
              Color(0xffAA6728),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // sudoku pattern TODO

        //child: Container(
        //  alignment: Alignment.center,
        child: Column(
          children: [
            // TODO vrchní část
            Expanded(
              //flex: 1,
              child: Container(
                //height: 50,
                color: Colors.deepOrange,
              ),
            ),

            // TODO prostřední část
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blueGrey,
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                //height: 50,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (buildContext, index) {
                    return Container(
                      color: Colors.red,
                      //height: 50,
                      //padding: const EdgeInsets.all(20),

                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        itemCount: 9,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2.5,
                          mainAxisSpacing: 2.5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (buildContext, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: Text("${index + 1}"),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            // TODO spodní část
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.lightGreen,
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                //padding: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                //height: 50,
                width: double.maxFinite,
                //width: 200,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (buildContext, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //height: 50,
                      //padding: const EdgeInsets.all(20),
                      //width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    );
                  },
                ),
              ),
            ),
            // TODO nejspodnější část
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.orangeAccent,
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                //padding: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                //height: 50,
                width: double.maxFinite,
                //width: 200,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (buildContext, index) {
                    return Container(
                      color: Colors.blueAccent,
                      //height: 50,
                      //padding: const EdgeInsets.all(20),
                      //width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
