import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;

  String username = "";
  String password = "";
  bool isLoginSuccess = true;

  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool("login") ?? true);
    print(newuser);
    if(newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage())
      );
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget _pageTitle() {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10,200,10,60),
        child: Text(
          'Log In',
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w700,
              fontSize: 30),
        ),
      );
    }

    Widget _usernameField() {
      return Container(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: TextFormField(
          controller: username_controller,
          enabled: true,
          decoration: InputDecoration(
            hintText: 'Username',
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: const OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(24.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(24.0)),
              borderSide: BorderSide(color: (isLoginSuccess) ? Colors.grey : Colors.red),
            ),
          ),
        ),
      );
    }

    Widget _passwordField() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: TextFormField(
          controller: password_controller,
          enabled: true,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              borderSide: BorderSide(color: Colors.black54)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(24.0)),
              borderSide: BorderSide(color: (isLoginSuccess) ? Colors.grey : Colors.red),
            ),
          ),
        ),
      );
    }

    Widget _loginButton(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            username = username_controller.text;
            password = password_controller.text;
            String text = "";
            if (username == "1" && password == "2") {
              setState(() {
                text = "Login Sukses";
                isLoginSuccess = true;
              });
              logindata.setBool("login", false);
              logindata.setString("username", username);
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              setState(() {
                text = "Login Gagal";
                isLoginSuccess = false;
              });
            }
            SnackBar snackBar = SnackBar(
              content: Text(text),
              backgroundColor: (isLoginSuccess)? Colors.green : Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text('Login'),
          style: ElevatedButton.styleFrom(
            primary: Colors.black54,
            padding: const EdgeInsets.all(20),
            // primary: Colors.tea,
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Login Page"),
        // ),
        body: Container(
            color: Colors.white10,
            child: Column(
              children: [
                _pageTitle(),
                _usernameField(),
                _passwordField(),
                _loginButton(context),
              ]
            ),
        ),
      ),
    );
  }
}