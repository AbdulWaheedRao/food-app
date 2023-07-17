// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MYCartPage extends StatefulWidget {
  const MYCartPage({super.key});

  @override
  State<MYCartPage> createState() => _MYCartPageState();
}

class _MYCartPageState extends State<MYCartPage> {
  @override
  Widget build(BuildContext context) {
    // final mini = min(height, width);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff493f4a),
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final firestore = FirebaseFirestore.instance.collection('Orders').snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final clientHeight = height - kToolbarHeight;
    final cleintWidth = width - kToolbarHeight;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Color(0xff493f4a), Color(0xff5f4045)])),
        child: StreamBuilder(
          stream: firestore,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            } else if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff493f4a), Color(0xff5f4045)])),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: width,
                          height: height,
                          child: Column(
                            children: [
                              SizedBox(
                                height: clientHeight * 0.4,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: cleintWidth * 1,
                                    height: clientHeight * 0.04,
                                    child: FittedBox(
                                      child: Text(
                                        'Alas! Your Cart is Empty, Pleas Add',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: cleintWidth * 1,
                                    height: clientHeight * 0.04,
                                    child: FittedBox(
                                      child: Text(
                                        'some items to your Cart before ',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: cleintWidth * 0.9,
                                    height: clientHeight * 0.04,
                                    child: FittedBox(
                                      child: Text(
                                        'Checkout',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: width,
                          height: height,
                          child: Column(
                            children: [
                              SizedBox(
                                height: clientHeight * 0.2,
                              ),
                              Container(
                                width: cleintWidth * 0.75,
                                height: clientHeight * 0.1,
                                decoration: const BoxDecoration(
                                    color: Color(0xffe8c03a),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Center(
                                  child: SizedBox(
                                    width: cleintWidth * 0.5,
                                    height: clientHeight * 0.06,
                                    child: const FittedBox(
                                      child: Text(
                                        'Explore Products',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        // height: clientHeight * 0.5,
                        // width: clientWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: [Color(0xff493f4a), Color(0xff5f4045)]),
                          boxShadow: [
                            const BoxShadow(
                                blurRadius: 2,
                                color: Color.fromARGB(255, 76, 74, 74),
                                offset: Offset(2, 2),
                                spreadRadius: 2),
                            BoxShadow(
                                blurRadius: 2,
                                color: const Color.fromARGB(255, 76, 74, 74)
                                    .withOpacity(0.4),
                                offset: const Offset(-2, -2),
                                spreadRadius: 2)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: cleintWidth * 0.015,
                            ),
                            Container(
                                height: clientHeight * 0.3,
                                width: clientHeight * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  snapshot.data!.docs[index]['imagePath'],
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              height: clientHeight * 0.17,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Name:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['imageName'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Price:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot
                                                .data!.docs[index]['imagePrice']
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '       Quantity:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['noOrders']
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // const Icon(Icons.delete_forever)
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
