import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation_page_material_rout/Display_Add_to_Cart.dart';
import 'package:hero_animation_page_material_rout/Models/products.dart';
import 'package:hero_animation_page_material_rout/my_cart.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.id,
      required this.imagePath,
      required this.imageName,
      required this.imagePrice,
      this.noOrders});
  final String id;
  final String imagePath;
  final String imageName;
  final num imagePrice;
  final int? noOrders;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<QuerySnapshot<Map<String, dynamic>>> firestore;
  // final _auth = FirebaseAuth.instance;
  int noOrders = 1;
  final firestores = FirebaseFirestore.instance.collection('Orders');
  Product? hotel;

  void addCart() {
    firestores.doc().set({
      'imageName': widget.imageName,
      'imagePath': widget.imagePath,
      "imagePrice": widget.imagePrice,
      "noOrders": noOrders,
    });
  }

  int number = 0;
  void increment() {
    setState(() {
      noOrders++;
    });
  }

  void decrement() {
    setState(() {
      noOrders--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final clientHieght = height - kToolbarHeight;
    final mini = min(height, width);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff493f4a),
        leading: InkWell(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.07),
            child: InkWell(
                onTap: (() {
                  Navigator.of(context).push(createRoutRider());
                }),
                child: Icon(
                  Icons.child_friendly,
                  size: mini * 0.08,
                )),
          ),
        ],
      ),
      body: Container(
        width: width,
        height: clientHieght,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Color(0xff493f4a), Color(0xff5f4045)])),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                // color: Colors.pink,
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: clientHieght * 0.04,
                    // ),
                    Container(
                      // color: Colors.green,
                      width: width * 0.97,
                      height: clientHieght * 0.31,
                      child: Stack(children: [
                        Positioned(
                          left: width * 0.03,
                          child: Container(
                              width: width * 0.9,
                              height: clientHieght * 0.3,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Color(0xff625b63),
                              )),
                        ),
                        Positioned(
                            left: width * 0.055,
                            top: clientHieght * 0.025,
                            child: Hero(
                              tag: widget.id,
                              child: Container(
                                width: width * 0.85,
                                height: clientHieght * 0.27,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  color: Color(0xff575258),
                                ),
                                child: Image.network(
                                  widget.imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  // color: Colors.green,
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.9,
                        height: clientHieght * 0.11,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [Color(0xff6b5667), Color(0xff392f37)]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width * 0.15,
                                    height: clientHieght * 0.03,
                                    child: FittedBox(
                                      child: Text(
                                        widget.imageName.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.15,
                                    height: clientHieght * 0.03,
                                    child: FittedBox(
                                      child: Text(widget.imagePrice.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                // color: Colors.pink,
                                width: width * 0.3,
                                height: clientHieght * 0.02,
                                child: FittedBox(
                                  child: Text(
                                    'Tast that you Love',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.5)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 10,
                child: Container(
                  // color: Colors.orange,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: const Color(0xffeab54f),
                                  size: mini * 0.07,
                                ),
                                SizedBox(
                                  width: width * 0.15,
                                  height: clientHieght * 0.03,
                                  child: const SizedBox(
                                    child: FittedBox(
                                      child: Text(
                                        ' 20-30',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.1,
                                  height: clientHieght * 0.02,
                                  child: const FittedBox(
                                    child: Text(
                                      'mint',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    decrement();
                                  }),
                                  child: Container(
                                    width: width * 0.1,
                                    height: height * 0.05,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 197, 196, 196),
                                              offset: Offset(0, 1.3)),
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 197, 196, 196),
                                              offset: Offset(0.4, 0)),
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 197, 196, 196),
                                              offset: Offset(-0.4, 0)),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Center(
                                      child: AutoSizeText(
                                        '-',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w100,
                                        ),
                                        // maxLines: 3,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.017,
                                ),
                                AutoSizeText(
                                  '$noOrders',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  // maxLines: 3,
                                ),
                                SizedBox(
                                  width: width * 0.017,
                                ),
                                InkWell(
                                  onTap: (() {
                                    increment();
                                  }),
                                  child: Container(
                                    width: width * 0.1,
                                    height: height * 0.05,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 197, 196, 196),
                                              offset: Offset(0, 1.3)),
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 197, 196, 196),
                                              offset: Offset(0.4, 0)),
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 197, 196, 196),
                                              offset: Offset(-0.4, 0)),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Center(
                                      child: AutoSizeText(
                                        '+',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w100,
                                        ),
                                        // maxLines: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.55),
                        child: SizedBox(
                          width: width * 0.3,
                          height: clientHieght * 0.05,
                          child: const FittedBox(
                            child: Text(
                              'Awesom',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DisplayAddToCartOrders(),
                              ));
                          addCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Your Order has been placed')));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.53),
                          child: Container(
                            width: width * 0.35,
                            height: clientHieght * 0.067,
                            decoration: const BoxDecoration(
                                color: Color(0xffeab54f),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: SizedBox(
                                width: width * 0.3,
                                height: clientHieght * 0.05,
                                child: FittedBox(
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      ScaleAnimatedText('Add to Cart',
                                          duration:
                                              const Duration(milliseconds: 300),
                                          scalingFactor: 0.3,
                                          textStyle: const TextStyle(
                                              color: Color(0xff392f37),
                                              fontWeight: FontWeight.w900))
                                    ],
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                    displayFullTextOnTap: true,
                                    totalRepeatCount: 3,
                                    pause: const Duration(milliseconds: 100),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Route createRoutRider() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => const MYCartPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: const Offset(0.0, -1.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
