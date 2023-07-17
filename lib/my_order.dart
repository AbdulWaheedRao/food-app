// import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // final clientHieght = height - kToolbarHeight;
    // final mini = min(height, width);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: const Color(0xffcaa21e),
        elevation: 0,
        leading: InkWell(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: const Icon(Icons.arrow_back_ios)),
        actions: const [],
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff63564d), Color(0xff2d241d)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    FlickerAnimatedText(
                        'Alas! Your Cart is Empty, Pleas Add\n    some items to your Cart before\n                        Checkout',
                        textStyle: TextStyle(
                            color: Colors.white.withOpacity(0.3), fontSize: 20))
                  ],
                  // isRepeatingAnimation: true,
                  repeatForever: true,
                  displayFullTextOnTap: true,
                  totalRepeatCount: 3,
                  pause: const Duration(milliseconds: 100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
