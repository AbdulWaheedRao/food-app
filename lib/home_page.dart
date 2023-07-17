// import 'dart:math'

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation_page_material_rout/Display_Add_to_Cart.dart';
import 'package:hero_animation_page_material_rout/Food_Products/Biryani.dart';
import 'package:hero_animation_page_material_rout/Food_Products/Kabab.dart';
import 'package:hero_animation_page_material_rout/Food_Products/Nuggets.dart';
import 'package:hero_animation_page_material_rout/Food_Products/Pizza.dart';
import 'package:hero_animation_page_material_rout/Food_Products/Showarma.dart';
import 'package:hero_animation_page_material_rout/Food_Products/Wings.dart';
import 'package:hero_animation_page_material_rout/my_cart.dart';
import 'package:hero_animation_page_material_rout/my_order.dart';
import 'package:hero_animation_page_material_rout/sign_in_activity.dart';
import 'detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  DisplayAddToCartOrders orders = DisplayAddToCartOrders();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final clientHeight = height - kToolbarHeight;
    // final mini = min(height, width);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff6c5f56),
          elevation: 0,
          // bottom: ,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: (() {
                  Navigator.of(context).push(createRoutRider());
                }),
                child: const Icon(
                  Icons.child_friendly,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            width: width,
            height: clientHeight,
            decoration: const BoxDecoration(
                color: Colors.grey,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff6c5f56), Color(0xff302720)],
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: clientHeight * 0.03,
                        ),
                        SizedBox(
                          width: width * 0.5,
                          height: clientHeight * 0.05,
                          child: const FittedBox(
                            child: Text(
                              'Mehran Kitchen',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'fonts',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.25,
                          height: clientHeight * 0.025,
                          child: const FittedBox(
                            child: Text(
                              'Better taste',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: clientHeight * 0.025,
                        ),
                        SizedBox(
                          width: width * 0.4,
                          height: clientHeight * 0.05,
                          child: const FittedBox(
                            child: Text(
                              'Most Favourite',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        tabs: const [
                          Tab(
                            child: Text('Biryani'),
                          ),
                          Tab(
                            child: Text('Wings'),
                          ),
                          Tab(
                            child: Text('Showarma'),
                          ),
                          Tab(
                            child: Text('Kabab'),
                          ),
                          Tab(
                            child: Text('Pizza'),
                          ),
                          Tab(
                            child: Text('Nuggets'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child:
                      TabBarView(controller: _tabController, children: const [
                    BiryaniFastFood(),
                    WingsFastFood(),
                    ShowarmaFastFood(),
                    KababFastFood(),
                    PizzaFastFood(),
                    NuggetsFastFood(),
                  ]),
                ),

                // TabBarView(controller: _tabController, children: const [
                //   Text('ncfgfjnv'),
                //   Text('ncfgfjnv'),
                //   Text('ncfgfjnv'),
                //   Text('ncfgfjnv'),
                //   Text('ncfgfjnv'),
                // ]),
              ],
            ),
          ),
        ),
        drawer: SafeArea(
            child: Drawer(
                backgroundColor: const Color(0xff302b27),
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xff675263), Color(0xff382e36)])),
                    child: Column(children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          // color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 273, top: 3),
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: clientHeight * 0.05,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 25),
                                        child: Row(
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                'Muhammad Junaid ',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    color: Color(0xffcaa21e)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AnimatedTextKit(
                                        animatedTexts: [
                                          RotateAnimatedText('Live Free',
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                          RotateAnimatedText('Eat Right',
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white)),
                                          RotateAnimatedText(
                                            'Eat Today',
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                        isRepeatingAnimation: true,
                                        repeatForever: true,
                                        totalRepeatCount: 300,
                                        pause:
                                            const Duration(milliseconds: 300),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: clientHeight * 0.06,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      width: width * 0.6,
                                      height: 1,
                                      color:
                                          const Color.fromARGB(255, 92, 87, 91),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: Container(
                              // color: Colors.green,
                              child: Column(children: [
                            SizedBox(
                                width: 270,
                                height: clientHeight * 0.4,
                                // color: Colors.green,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: clientHeight * 0.05,
                                            width: 50,
                                            child: const FittedBox(
                                              child: Icon(
                                                Icons.add_home,
                                                color: Color(0xffcaa21e),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(createPageRoute());
                                            },
                                            child: SizedBox(
                                              width: 50,
                                              height: clientHeight * 0.05,
                                              child: const FittedBox(
                                                child: Text(
                                                  'Home',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: 270,
                                        height: clientHeight * 0.004,
                                        color: const Color(0xff50404a),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: clientHeight * 0.05,
                                            width: 50,
                                            child: const FittedBox(
                                              child: Icon(
                                                Icons.card_travel,
                                                color: Color(0xffcaa21e),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MYCartPage()));
                                            }),
                                            child: SizedBox(
                                              width: 60,
                                              height: clientHeight * 0.05,
                                              child: const FittedBox(
                                                child: Text(
                                                  'My Cart',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: 270,
                                        height: clientHeight * 0.004,
                                        color: const Color(0xff50404a),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: clientHeight * 0.05,
                                            width: 50,
                                            child: const FittedBox(
                                              child: Icon(
                                                Icons.sign_language_sharp,
                                                color: Color(0xffcaa21e),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (() {
                                              FirebaseAuth.instance.signOut();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignInPage()));
                                            }),
                                            child: SizedBox(
                                              width: 60,
                                              height: clientHeight * 0.05,
                                              child: const FittedBox(
                                                child: Text(
                                                  'Sign Out',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: 270,
                                        height: clientHeight * 0.004,
                                        color: const Color(0xff50404a),
                                      ),
                                    ]))
                          ])))
                    ])))));
  }
}

Route createPageRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: const Offset(-1, -1), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
