import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/services/database.dart';
import 'package:quiz_inventor_app/views/add_question_screen.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImgUrl, quizTitle, quizDesc, quizId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        'quizId': quizId,
        'quizImgUrl': quizImgUrl,
        'quizTitle': quizTitle,
        'quizDesc': quizDesc
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddQuestion(quizId: quizId,)));
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
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Image Url' : null,
                      decoration: InputDecoration(
                        hintText: 'Quiz Image Url',
                      ),
                      onChanged: (val) {
                        quizImgUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Quiz Title' : null,
                      decoration: InputDecoration(
                        hintText: 'Quiz Title',
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Quiz Description' : null,
                      decoration: InputDecoration(
                        hintText: 'Quiz Description',
                      ),
                      onChanged: (val) {
                        quizDesc = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () => createQuizOnline(),
                        child: blueButton(
                           context: context,
                            label:'Create Quiz'
                        )),
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
