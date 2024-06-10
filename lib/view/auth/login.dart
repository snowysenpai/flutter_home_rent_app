import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/view/auth/register.dart';
import 'package:home_rent/view/bottomnavi.dart';
import 'package:toastification/toastification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({super.key});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  bool loading = false;
  bool floading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/log.png',
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Login the App",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "context@email.com",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: passwdController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwdController.text);
                    toastification.show(
                        context: context,
                        type: ToastificationType.success,
                        title: const Text('Success'),
                        description: const Text.rich(
                            TextSpan(text: 'Login Successful!!')),
                        autoCloseDuration: const Duration(seconds: 4),
                        icon: const Icon(Icons.check));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNavi()));
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool("login", true);
                    prefs.setString("email", emailController.text);
                    prefs.setString("passwd", passwdController.text);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'invalid-credential') {
                      toastification.show(
                          context: context,
                          type: ToastificationType.error,
                          title: const Text('Error'),
                          description: const Text.rich(
                              TextSpan(text: 'Email or password is invalid!!')),
                          autoCloseDuration: const Duration(seconds: 4),
                          icon: const Icon(Icons.error));
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 60),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const register()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
