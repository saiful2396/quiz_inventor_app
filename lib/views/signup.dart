import 'package:flutter/material.dart';
import 'package:quiz_inventor_app/helper/functions.dart';
import 'package:quiz_inventor_app/services/auth.dart';
import 'package:quiz_inventor_app/views/signin.dart';
import 'package:quiz_inventor_app/widgets/widgets.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signUpEmailAndPass(email, password).then((value) {
        if (value != null) {
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
        centerTitle: true,
        title: appBar(context),
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
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? 'Enter Your Name' : null;
                      },
                      decoration: InputDecoration(
                        hintText: 'FullName',
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? 'Enter Your Email' : null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.isEmpty ? 'Enter Your Password' : null;
                      },
                      decoration: InputDecoration(hintText: 'Password'),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 14),
                    InkWell(
                      onTap: () {
                        signUp();
                      },
                      child: blueButton(
                          context: context,
                          label: 'Sign Up'
                      ),),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => SignIn()));
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                  ],
                ),
              ),
            ),
    );
  }
}
