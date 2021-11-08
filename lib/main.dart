import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'question.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool nextQuesPrompt = false;
  int i = 0;
  List _questionData = [];
  List answersList = [];
  bool answerSelection = false;
  bool pressed = false;
  int correctans = 0;
  int wrongans = 0;

  Future<void> readJson() async {
    final response = await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    List<dynamic>? question = data != null ? List.from(data) : null;
    setState(() {
      _questionData = question!;
    });
  }

  List<dynamic> combineAnswers(int i) {
    answersList = List.from(_questionData[i]["incorrect_answers"]);
    answersList.add(_questionData[i]["correct_answer"]);
    answersList.shuffle();
    return answersList;
  }

  void checkAns(String ans) {
    if (ans == _questionData[i]["correct_answer"]) {
      setState(() {
        answerSelection = true;
      });
    } else {
      setState(() {
        answerSelection = false;
      });
    }
  }

  double percentageIndicator(int i) {
    return (i) / _questionData.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    if (_questionData.isNotEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 25, bottom: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(
                    value: percentageIndicator(i),
                    backgroundColor: Colors.white,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Question ${i + 1}',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    // '',
                    _questionData[i]["category"],
                    // _items[i]['category'].toString(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 10,
                    ),
                    Icon(
                      Icons.star,
                      color: _questionData[i]["difficulty"] == "medium" ||
                              _questionData[i]["difficulty"] == "hard"
                          ? Colors.black
                          : Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.star,
                      color: _questionData[i]["difficulty"] == "hard"
                          ? Colors.black
                          : Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.grey,
                      size: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _questionData[i]["question"],
                  // 'This is where your question will come. How does it look right now?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    OutlinedButton(
                      child: SizedBox(
                        height: 30,
                        width: 50,
                        child: Text(
                          combineAnswers(i)[0],
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        primary: Colors.grey,
                        onSurface: Colors.black,
                      ),
                      onPressed: pressed? (){

                      } : () {
                        pressed = true;
                        checkAns(combineAnswers(i)[0]);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      child: SizedBox(
                        height: 30,
                        width: 50,
                        child: Text(
                          combineAnswers(i)[1],
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        primary: Colors.grey,
                        onSurface: Colors.black,
                      ),
                      onPressed: pressed? (){

                      } : () {
                        pressed = true;
                        checkAns(combineAnswers(i)[1]);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                combineAnswers(i).length > 2
                    ? Row(
                        children: [
                          OutlinedButton(
                            child: SizedBox(
                              height: 30,
                              width: 50,
                              child: Text(
                                combineAnswers(i)[2] ?? '',
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white70,
                              primary: Colors.grey,
                              onSurface: Colors.black,
                            ),
                            onPressed: pressed? (){

                            } : () {
                              pressed = true;
                              checkAns(combineAnswers(i)[2] ?? '');
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          OutlinedButton(
                            child: SizedBox(
                              height: 30,
                              width: 50,
                              child: Text(
                                combineAnswers(i)[3] ?? '',
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white70,
                              primary: Colors.grey,
                              onSurface: Colors.black,
                            ),
                            onPressed: pressed? (){

                            } : () {
                              pressed = true;
                              checkAns(combineAnswers(i)[3] ?? '');
                            },
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                pressed
                    ? Column(
                        children: [
                          Text(
                            answerSelection == true ? 'Correct' : 'Sorry',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          ElevatedButton(
                            child: Text(
                              'Next Question',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              if (i < _questionData.length) {
                                setState(() {
                                  if (answerSelection == true) {
                                    correctans++;
                                  } else {
                                    wrongans++;
                                  }
                                  i++;
                                  pressed = false;
                                });
                              }
                            },
                          ),
                        ],
                      )
                    : SizedBox(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                i > 0
                                    ? 'Score: ${((correctans / (i + 1)) * 100).toInt()}%'
                                    : 'Score: ',
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                i > 0
                                    ? 'Max Score: ${(((_questionData.length - wrongans) / (_questionData.length)) * 100).toInt()}%'
                                    : 'Max Score: ',
                              ),
                            ),
                          ],
                        ),
                        if (correctans > 0 || wrongans > 0)
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: correctans > 0
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border(
                                    left: BorderSide(
                                        width: 1, color: Colors.black),
                                    top: BorderSide(
                                        width: 1, color: Colors.black),
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                                width: ((correctans / (i + 1))*100),
                                height: 8,
                                // color: correctans > 0 ? Colors.black : Colors.white,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: wrongans > 0 && i + 1 > 0
                                        ? Colors.grey
                                        : Colors.white,
                                    border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black),
                                      right: BorderSide(
                                          width: 1, color: Colors.black),
                                    )),
                                // width: wrongans.toDouble(),
                                height: 8,
                                width: (((wrongans) / (i+1)) * 100)
                                // color: wrongans > 0 && i+1 > 0
                                //     ? Colors.grey
                                //     : Colors.white,
                              ),
                              // Expanded(
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       border: Border(
                              //         right: BorderSide(
                              //             width: 1, color: Colors.black),
                              //         top: BorderSide(
                              //             width: 1, color: Colors.black),
                              //         bottom: BorderSide(
                              //             width: 1, color: Colors.black),
                              //       ),
                              //       color: i > 0 && correctans > 0
                              //           ? Colors.white70
                              //           : Colors.white,
                              //     ),
                              //     width: _questionData.length - (i + 1),
                              //     height: 8,
                              //     // color: i > 0 && correctans > 0
                              //     //     ? Colors.white70
                              //     //     : Colors.white,
                              //   ),
                              // )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            SizedBox(
              child: CircularProgressIndicator(color: Colors.black),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading...'),
            )
          ],
        )),
      );
    }
  }
}
