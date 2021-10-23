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
  final _random = new Random();
  int i = 0;
  List _questionData = [];
  List answersList = [];
  bool toggleAnswer = false;
  bool pressed = false;
  int correctans = 0;
  int wrongans = 0;



  Future<void> readJson() async {
    final response = await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    // final data1 = await json.decode(data);
    List<dynamic>? question = data != null ? List.from(data) : null;
    // Question question = Question.fromJson(data[0]);
    // print(question![0]['category']);
    setState(() {
      _questionData = question!;
    });
  }

  List combineAnswers(int i){
    answersList = _questionData[i]["incorrect_answers"];
    answersList.add(_questionData[i]["correct_answer"]);
    answersList.shuffle();
    return answersList;
  }

  void checkAns(String ans){
    if (ans == _questionData[i]["correct_answer"]){
      setState((){
        correctans++;
        toggleAnswer = true;
      });
    }
    else{
      setState((){
        wrongans++;
        toggleAnswer = false;
      });
    }
  }

  //GENERATE RANDOM NUMBER FOR RANDOM PLACEMENT OF OPTIONS
  double percentageIndicator(int i){
    return i/_questionData.length;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 25, bottom: 25),
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
                  'Question ${i+1}',
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
                    color: _questionData[i]["difficulty"] == "medium" || _questionData[i]["difficulty"] == "hard" ? Colors.black : Colors.grey,
                    size: 10,
                  ),
                  Icon(
                    Icons.star,
                    color: _questionData[i]["difficulty"] == "hard" ? Colors.black : Colors.grey,
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
                    onPressed: (){
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
                    onPressed: (){
                      pressed = true;
                      checkAns(combineAnswers(i)[1]);
                    },
                  ),
                ],
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
                        combineAnswers(i)[2],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      primary: Colors.grey,
                      onSurface: Colors.black,
                    ),
                    onPressed: (){
                      pressed = true;
                      checkAns(combineAnswers(i)[2]);
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
                        combineAnswers(i)[3],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      primary: Colors.grey,
                      onSurface: Colors.black,
                    ),
                    onPressed: (){
                      pressed = true;
                      checkAns(combineAnswers(i)[3]);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              pressed? Column(children: [Text(
                toggleAnswer == true ? 'Correct' : 'Sorry',
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
                  onPressed: (){
                    if(i < _questionData.length){
                      setState((){
                        // toggleAnswer = null;
                        pressed = false;
                        i++;
                      });
                    }
                  },
                ),],) : SizedBox(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: correctans > 0 ? Colors.black : Colors.white,
                        ),
                        flex: correctans > 0 ? (correctans/_questionData.length).round() : 1,
                      ),
                      Expanded(
                        child: Container(
                          color: wrongans > 0 && i > 0 ? Colors.grey : Colors.white,
                        ),
                        flex: wrongans > 0 && i > 0 ? (wrongans/i).round() : 1,
                      ),
                      Expanded(
                        child: Container(
                          color: i>0 && correctans>0 ? Colors.white70 : Colors.white,
                        ),
                        flex: i>0 && correctans>0 ? ( ((correctans+(_questionData.length - i))/_questionData.length).round() ) : 1,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
