import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';

class Result extends StatefulWidget {

  final int correct, incorrect, total;
  Result({
    @required this.correct,
    @required this.incorrect,
    @required this.total,
  });

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.correct}/${widget.total}',
              style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 8,),
              Text('You answered ${widget.correct} answers correctly'
                  ' and ${widget.incorrect} answers incorrectly',
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: blueButton(
                      context: context,
                      label: 'Go to Home',
                    buttonWidth: MediaQuery.of(context).size.width/2
                  ),
              )
            ],
          )
        ),
      ),
    );
  }
}
