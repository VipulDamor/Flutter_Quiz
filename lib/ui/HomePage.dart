import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizler/beans/questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> icons = [];
  int countQuestions = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.all(21.0),
                child: Text(
                  getQuestionAnswers().asMap().containsKey(countQuestions)
                      ? getQuestionAnswers()[countQuestions].questionText
                      : getQuestionAnswers()[countQuestions - 1].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: TextButton(
                onPressed: () {
                  resetcounterifNeeded(true, context);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(21.0, 0.0, 21.0, 8.0),
                  width: double.infinity,
                  padding: EdgeInsets.all(18.0),
                  color: Colors.green,
                  child: Text(
                    'true',
                    style: TextStyle(color: Colors.white, fontSize: 21.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: TextButton(
                onPressed: () {
                  resetcounterifNeeded(false, context);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(21.0, 0, 18.0, 0.0),
                  width: double.infinity,
                  padding: EdgeInsets.all(18.0),
                  color: Colors.green,
                  child: Text(
                    'false',
                    style: TextStyle(color: Colors.white, fontSize: 21.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.fromLTRB(21.0, 8.0, 21.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: icons,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetcounterifNeeded(bool correctanswer, BuildContext context) {
    setState(() {
      if (countQuestions >= getQuestionAnswers().length) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Yay..!!",
          desc: "Quiz Completed",
          buttons: [
            DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  countQuestions = 0;
                  icons.clear();
                });
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        if (getQuestionAnswers()[countQuestions].questionanswer ==
            correctanswer) {
          icons.add(addicons(true));
        } else {
          icons.add(addicons(false));
        }
        countQuestions++;
      }

      print('after counter is : $countQuestions');
    });
  }

  List<Question> getQuestionAnswers() {
    List<Question> _qalist = [
      Question('The Big Apple is a nickname given to Washington D.C in 1971.',
          false),
      Question('Muddy York is a nickname for New York in the Winter.', false),
      Question('Peanuts are not nuts!', true),
      Question('People may sneeze or cough while sleeping deeply.', false),
      Question('Copyrights depreciate over time.', true)
    ];
    return _qalist;
  }
}

Icon addicons(bool variabe) {
  if (variabe == true) {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  } else {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }
}
