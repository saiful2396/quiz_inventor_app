import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/services/database.dart';
import 'package:quiz_inventor_app/views/home.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {

  final String quizId;
  AddQuestion({this.quizId});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;


  uploadQuizData(){
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        'question' : question,
        'option1' : option1,
        'option2' : option2,
        'option3' : option3,
        'option4' : option4,
      };
      databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
            setState(() {
              _isLoading = false;
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),

      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? 'Enter Your question' : null,
                decoration: InputDecoration(
                  hintText: 'Question',
                ),
                onChanged: (val) {
                  question = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? 'Enter Option1' : null,
                decoration: InputDecoration(
                  hintText: 'Option1(Correct Answer)',
                ),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? 'Enter Option2' : null,
                decoration: InputDecoration(
                  hintText: 'Option2',
                ),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? 'Enter Option3' : null,
                decoration: InputDecoration(
                  hintText: 'Option3',
                ),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? 'Enter Option4' : null,
                decoration: InputDecoration(
                  hintText: 'Option4',
                ),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: ()=> Navigator.push(context,
                        MaterialPageRoute(builder: (_)=>Home())),
                    child: blueButton(
                        context: context, label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 -36
                    ),
                  ),
                  SizedBox(width: 24,),
                  InkWell(
                    onTap: (){
                      uploadQuizData();
                    },
                    child: blueButton(
                        context: context, label: 'Add Question',
                      buttonWidth: MediaQuery.of(context).size.width/2 -36
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),

    );
  }
}
