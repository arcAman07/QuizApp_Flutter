import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {


  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List<String>question=[
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //       'A slug\'s blood is green.'];
  // List<bool>answers = [
  //   false,true,false
  // ];
  // List<Question> questionBank = [Question('You can lead a cow down stairs but not up stairs.',false),
  // Question('Approximately one quarter of human bones are in the feet.',true),
  // Question('A slug\'s blood is green.',false)];
  // int questionNumber = 0;
  List<Icon>scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();
  int questionNumber = 0;
  int totCorrect = 0;
  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (correctAnswer == userPickedAnswer){

      print("User got it right");
      totCorrect++;
      scoreKeeper.add(Icon(
        Icons.check,
        color:Colors.green,
      ));}
    else {
      print("User got it wrong");
      scoreKeeper.add(Icon(
        Icons.close,
        color:Colors.red,
      ),);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);

                setState(() {
                  if (questionNumber<12){
                    quizBrain.nextQuestion();
                    questionNumber++;
                  }
                  else{
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "QUIZ END",
                      desc: "You score is $totCorrect out of 13, hopefully you liked this short Quiz.",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "REVIEW US",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                        ),
                        DialogButton(
                          child: Text(
                            "TRY AGAIN",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                            scoreKeeper=[];
                            questionNumber=0;
                            totCorrect=0;
                            setState(() {

                            });
                            },
                          gradient: LinearGradient
                          (colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                        )
                      ],
                    ).show();
                  }

                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);

                //The user picked false.
                setState(() {
    if (questionNumber<12){
    quizBrain.nextQuestion();
    questionNumber++;
    }
    else{
    Alert(
    context: context,
    type: AlertType.warning,
    title: "QUIZ END",
    desc: "You score is $totCorrect out of 13, hopefully you liked this short Quiz.",
    buttons: [
    DialogButton(
    child: Text(
    "REVIEW US",
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    onPressed: () => Navigator.pop(context),
    color: Color.fromRGBO(0, 179, 134, 1.0),
    ),
    DialogButton(
    child: Text(
    "TRY AGAIN",
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    onPressed: (){
      Navigator.pop(context);
      scoreKeeper=[];
      questionNumber=0;
      totCorrect=0;
      setState(() {

      });
    },
    gradient: LinearGradient(colors: [
    Color.fromRGBO(116, 116, 191, 1.0),
    Color.fromRGBO(52, 138, 199, 1.0)
    ]),
    )
    ],
    ).show();

    }




    });},
            ),
          ),
        ),
        Row(
          children:scoreKeeper,

        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
