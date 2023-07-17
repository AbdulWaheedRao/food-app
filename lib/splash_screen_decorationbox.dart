import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation_page_material_rout/home_page.dart';
import 'package:hero_animation_page_material_rout/sign_in_activity.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  // bool _initial = true;
  SplashServices services = SplashServices();

  @override
  void initState() {
    services.isLogin(context);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = DecorationTween(
      begin: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black45,
          style: BorderStyle.solid,
          width: 3.0,
        ),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 10.0,
            spreadRadius: 4.0,
          )
        ],
      ),
      end: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.black87,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        shape: BoxShape.circle,
        // No shadow.
      ),
    ).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 82, 75, 75),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBoxTransition(
              position: DecorationPosition.background,
              decoration: animation as Animation<Decoration>,
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  padding: const EdgeInsets.all(50),
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'assets/images/pizze-removebg-preview.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ));
        timer.cancel();
      });
    } else {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInPage(),
            ));
        timer.cancel();
      });
    }
  }
}
