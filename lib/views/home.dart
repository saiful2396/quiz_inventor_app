import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/services/database.dart';
import 'package:quiz_inventor_app/views/create_quiz.dart';
import 'package:quiz_inventor_app/views/play_quiz.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot.data == null
              ? Container() :
              ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    return QuizTile(
                      imgUrl: snapshot.data
                          .documents[index]
                          .data['quizImgUrl'],
                      desc: snapshot.data.documents[index]
                          .data['quizDesc'],
                      title: snapshot.data.documents[index]
                          .data['quizTitle'],
                      quizId: snapshot.data.documents[index]
                          .data['quizId'],
                    );
                  }
              );
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizesData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => CreateQuiz())),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {

  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;

  QuizTile({
    @required this.imgUrl,
    @required this.title,
    @required this.desc,
    @required this.quizId
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (_)=>PlayQuiz(
                quizId
            )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white,
                        fontSize: 17,fontWeight: FontWeight.w500
                    ),),
                  SizedBox(height: 6,),
                  Text(
                    desc,
                    style: TextStyle(color: Colors.white,
                        fontSize: 17,fontWeight: FontWeight.w500),),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
