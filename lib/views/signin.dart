import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/helper/functions.dart';
import 'package:quiz_inventor_app/services/auth.dart';
import 'package:quiz_inventor_app/views/home.dart';
import 'package:quiz_inventor_app/views/signup.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
            HelperFunctions.saveUserLoginDetails(isLoggedIn: true);
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true ,
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
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? 'Enter Your Email' : null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (val) => email = val,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? 'Enter Correct password' : null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'password'),
                      onChanged: (val) => password = val,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    InkWell(
                        onTap: () {
                          signIn();
                        },
                        child: blueButton(
                            context:context,
                            label:'Sign In'
                        )),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account ? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => SignUp()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
