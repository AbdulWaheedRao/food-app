import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayAddToCartOrders extends StatefulWidget {
  const DisplayAddToCartOrders({
    super.key,
  });

  @override
  State<DisplayAddToCartOrders> createState() => _DisplayAddToCartOrdersState();
}

Random random = Random();

class _DisplayAddToCartOrdersState extends State<DisplayAddToCartOrders> {
  final firestore = FirebaseFirestore.instance.collection('Orders').snapshots();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    var clientHeight = screenHeight - kToolbarHeight;
    // var clientWidth = screenWidth - kToolbarHeight;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff493f4a),
          elevation: 0,
          title: const Text(
            "Orders",
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
        body: Container(
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
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

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
                              width: screenWidth * 0.015,
                            ),
                            Container(
                                height: clientHeight * 0.3,
                                width: screenWidth * 0.8,
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
            },
          ),
        ));
  }
}
