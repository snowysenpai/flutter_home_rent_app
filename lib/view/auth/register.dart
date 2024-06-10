// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/api/message_user.dart';
import 'package:home_rent/view/auth/login.dart';
import 'package:toastification/toastification.dart';

class register extends StatefulWidget {
  const register({
    super.key,
  });

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
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
                "Register the App",
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
                  maxLength: 128,
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
                child: const Text("Register"),
                onPressed: () async {
                  try {
                    final time =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwdController.text);

                    final newUser = MessageUser(
                        image: "",
                        about: "",
                        name: "Not set",
                        createdAt: time,
                        id: FirebaseAuth.instance.currentUser!.uid,
                        isOnline: false,
                        lastActive: time,
                        email: emailController.text,
                        pushToken: "",
                        lastName: "Not set",);

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set(newUser.toJson());
                    toastification.show(
                      context: context,
                      type: ToastificationType.success,
                      autoCloseDuration: const Duration(seconds: 3),
                      icon: const Icon(Icons.check),
                      title: const Text('Success'),
                      description: const Text.rich(
                        TextSpan(
                          text: 'User Registered Successfully',
                        ),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginWithEmail(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      // print('The password provided is too weak.');
                      toastification.show(
                        context: context,
                        type: ToastificationType.error,
                        autoCloseDuration: const Duration(seconds: 3),
                        icon: const Icon(Icons.error),
                        title: const Text('Error'),
                        description: const Text.rich(
                          TextSpan(
                            text: 'The password provided is too weak.',
                          ),
                        ),
                      );
                    } else if (e.code == 'email-already-in-use') {
                      // print('The account already exists for that email.');
                      toastification.show(
                        context: context,
                        type: ToastificationType.error,
                        autoCloseDuration: const Duration(seconds: 3),
                        icon: const Icon(Icons.error),
                        title: const Text('Error'),
                        description: const Text.rich(
                          TextSpan(
                            text: 'The account already exists for that email.',
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
