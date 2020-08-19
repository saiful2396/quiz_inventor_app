import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/models/question_models.dart';
import 'package:quiz_inventor_app/services/database.dart';
import 'package:quiz_inventor_app/views/results.dart';
import 'package:quiz_inventor_app/widgets/quiz_play_widget.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}
int total = 0;
int _correct = 4;
int _inCorrect = 0;
int _notAttemted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot questionsSnapshot;
  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = QuestionModel();
    questionModel.question = questionSnapshot.data['question'];
    List<String> options = [
      questionSnapshot.data['option1'],
      questionSnapshot.data['option2'],
      questionSnapshot.data['option3'],
      questionSnapshot.data['option4'],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data['option1'];
    questionModel.answered = false;
    return questionModel;

  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttemted = 0;
      _correct = 0;
      _inCorrect = 0;
      total = questionsSnapshot.documents.length;
      print('total}');
      setState(() {

      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              questionsSnapshot == null ?
                  Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ): ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                  itemBuilder: (context, index){
                  return QuizPlayTile(
                    questionModel : getQuestionModelFromDatasnapshot
                      (questionsSnapshot.documents[index]),
                    index: index,
                  );
                  })
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_)=>Result(
                  correct: _correct,  incorrect: _inCorrect, total: total)
              ));
        },
        child: Icon(Icons.check),
      ),

    );
  }
}

class QuizPlayTile extends StatefulWidget {

  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Q${widget.index+1} ${widget.questionModel.question}',
              style: TextStyle(fontSize: 17, color: Colors.black87),
          ),
          SizedBox(height: 12,),
          InkWell(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option1 ==
                widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttemted = _notAttemted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _inCorrect = _inCorrect - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
                option: "A",
                description: widget.questionModel.option1,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 4,),
          InkWell(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option2 ==
                    widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttemted = _notAttemted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _inCorrect = _inCorrect - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
                option: "B",
                description: widget.questionModel.option2,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 4,),
          InkWell(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option3 ==
                    widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttemted = _notAttemted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _inCorrect = _inCorrect - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
                option: "C",
                description: widget.questionModel.option3,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 4,),
          InkWell(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option4 ==
                    widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttemted = _notAttemted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _inCorrect = _inCorrect - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
                option: "D",
                description: widget.questionModel.option4,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
