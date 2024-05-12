import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quicktask/data/userremotestore.dart';
import 'package:quicktask/pages/resetpasswordpage.dart';
import 'package:quicktask/pages/signuppage.dart';
import 'package:quicktask/pages/todolistpage.dart';
import 'package:quicktask/widgets/button.dart';
import 'package:quicktask/widgets/message.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  final UserRemoteStore userRemoteStore = UserRemoteStore();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Task'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(
              height: 200,
              child:
                  Image(image: AssetImage('assets/icon/quick_task_banner.png')),
            ),
            const Center(
              child: Text('Quick Task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controllerUsername,
              enabled: !isLoggedIn,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  labelText: 'Username'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: controllerPassword,
              enabled: !isLoggedIn,
              obscureText: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  labelText: 'Password'),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              child: Button(
                text: 'Login',
                onPressed: isLoggedIn ? () {} : () => doUserLogin(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              child: Button(
                text: 'Sign Up',
                onPressed: () => navigateToSignUp(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              child: Button(
                text: 'Reset Password',
                onPressed: () => navigateToResetPassword(),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    userRemoteStore.doUserLogin(
        username, password, context, navigateToTaskPage);
  }

  void navigateToTaskPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ToDoListPage()),
      (Route<dynamic> route) => false,
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Signuppage()),
    );
  }

  void navigateToResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
    );
  }
}
