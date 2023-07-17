import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation_page_material_rout/Models/products.dart';
import 'package:hero_animation_page_material_rout/detail.dart';

class WingsFastFood extends StatefulWidget {
  const WingsFastFood({super.key});

  @override
  State<WingsFastFood> createState() => _WingsFastFoodState();
}

class _WingsFastFoodState extends State<WingsFastFood> {
  final fireStore = FirebaseFirestore.instance.collection('wings').snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final clientHeight = height - kToolbarHeight;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 88, 77, 69), Color(0xff302720)],
            )),
        child: StreamBuilder(
          stream: fireStore,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Center(
                child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    Product hotel =
                        Product.fromMap(snapshot.data!.docs[index].data());
                    // print('hotelllllllllllllll:$hotel');
                    return Center(
                        child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 41, 34, 33)
                                    .withOpacity(0.8),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Column(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (() {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                            builder: (context) => DetailPage(
                                                  id: hotel.id,
                                                  imagePath: hotel.imageURL,
                                                  imageName: hotel.imageName,
                                                  imagePrice: hotel.price,
                                                )));
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             DetailPage()));
                                  }),
                                  child: Hero(
                                    tag: hotel.id,
                                    child: Image.network(
                                      // scale: 0.1,
                                      width: 150.0,
                                      height: 100.0,

                                      hotel.imageURL,
                                      fit: BoxFit.cover,
                                    ),
                                    flightShuttleBuilder: (flightContext,
                                        animation,
                                        flightDirection,
                                        fromHeroContext,
                                        toHeroContext) {
                                      final Widget toHero =
                                          toHeroContext.widget;
                                      return RotationTransition(
                                        turns: animation,
                                        child: toHero,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.3,
                                  height: clientHeight * 0.035,
                                  child: FittedBox(
                                    child: Text(
                                      hotel.imageName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.2,
                                      height: clientHeight * 0.025,
                                      child: FittedBox(
                                        child: Text(
                                          hotel.discription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.2,
                                      height: clientHeight * 0.025,
                                      child: FittedBox(
                                        child: Text(hotel.price.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ]));
                  },
                ),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
