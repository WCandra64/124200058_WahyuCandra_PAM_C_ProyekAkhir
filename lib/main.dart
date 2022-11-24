import 'package:flutter/material.dart';
import 'package:proyek_akhir/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.grey,
      // ),
      home: LoginPage(),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final username_controller = TextEditingController();
//   final password_controller = TextEditingController();
//
//   late SharedPreferences logindata;
//   late bool newuser;
//
//   @override
//   void initState(){
//     super.initState();
//     checkLogin();
//   }
//
//   void checkLogin() async {
//     logindata = await SharedPreferences.getInstance();
//     newuser = (logindata.getBool("login") ?? true);
//     print(newuser);
//     if(newuser == false) {
//       Navigator.pushReplacement(
//         context, new MaterialPageRoute(builder: (context) => HomePage())
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     username_controller.dispose();
//     password_controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Shared Preference"),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               "Login Form",
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextField(
//                 controller: username_controller,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: "Username"
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextField(
//                 controller: password_controller,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Password"
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 String username = username_controller.text;
//                 String password = password_controller.text;
//                 if(username != '' && password != '') {
//                   print("Sukses");
//                   logindata.setBool("login", false);
//                   logindata.setString("username", username);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//                 }
//               },
//               child:
//                 const Text(
//                   "Login",
//                   style: TextStyle(color: Colors.white),
//                 )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
