import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/utils/appButton.dart';
import 'package:home_rent/utils/color.dart';
import 'dart:io' show Platform;

import 'package:home_rent/utils/gap.dart';
import 'package:home_rent/utils/login_option.dart';
import 'package:home_rent/view/auth/login.dart';
import 'package:home_rent/view/bottomnavi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _StartedScreenState() {
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loginState = prefs.getBool('login');
    String? email = prefs.getString('email');
    String? password = prefs.getString('passwd');
    FirebaseAuth auth = FirebaseAuth.instance;
    if (loginState == true) {
      await auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  BottomNavi()));
        toastification.show(
            context: context,
            type: ToastificationType.success,
            title: const Text('Success'),
            description:
                const Text.rich(TextSpan(text: 'Autologin Successful!!')),
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.check));
      }).catchError((e) {
        prefs.setBool('login', false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: Platform.isIOS ? 0 : 15),
          child: Column(
            children: [
              const Row(
                children: [
                  LoginOption(path: "assets/login1.png"),
                  Gap(isWidth: true, isHeight: false, width: 10),
                  LoginOption(path: "assets/login2.png"),
                ],
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const Row(
                children: [
                  LoginOption(path: "assets/login3.png"),
                  Gap(isWidth: true, isHeight: false, width: 10),
                  LoginOption(path: "assets/login4.png"),
                ],
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.155),
              const Row(
                children: [
                  Text(
                    "Welcome To ",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Home Rent Services",
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ],
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.035),
              AppButton(
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithEmail()));
                },
                title: "Get Started",
                textColor: AppColors.whiteColor,
                isButtonIcon: false,
                height: height * 0.08,
                radius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
