import 'package:TweetMe/services/AuthService.dart';
import 'package:TweetMe/widgets/Loading.dart';
import 'package:flutter/material.dart';
import '../utilities/constant.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _buildEmail(TextEditingController emailController) {
    return Column(
      children: [
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Masukkan Email',
                hintStyle: kHintTextStyle,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.only(top: 14.0)),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _buildPassword(TextEditingController passwordController) {
    return Column(
      children: [
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Masukkan Password',
                hintStyle: kHintTextStyle,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.only(top: 14.0)),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () async {
          loginAction(context);
        },
        child: Text(
          'Login'.toUpperCase(),
          style: TextStyle(
              color: Color(0xFF527DAA),
              fontSize: 18.0,
              letterSpacing: 1.5,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildGap() {
    return SizedBox(
      height: 30.0,
    );
  }

  void goToDashboard(BuildContext context) {
    Navigator.pushNamed(context, 'Dashboard');
  }

  void loginAction(BuildContext context) async {
    final enteredEmail = _emailController.text;
    final enteredPassword = _passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      return;
    }

    Loading().showLoading(context);

    bool onLoginSuccess =
        await AuthService().login(enteredEmail, enteredPassword);

    Loading().hideLoading(context);
    if (onLoginSuccess == true) {
      goToDashboard(context);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('periksa kembali kredensial anda'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (context) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ])),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                    _buildGap(),

                    // EMAIL INPUT
                    _buildEmail(_emailController),
                    _buildGap(),

                    // PASSWORD INPUT
                    _buildPassword(_passwordController),
                    _buildGap(),

                    // LOGIN BUTTON
                    _buildLoginButton(context)
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
