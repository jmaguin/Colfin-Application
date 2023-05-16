import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_finance_app/pages/constants.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TransectionPage extends StatefulWidget {
  const TransectionPage({super.key});

  @override
  State<TransectionPage> createState() => _TransectionPageState();
}

class _TransectionPageState extends State<TransectionPage> {
  late Future<List<ApiConstant>> futureAlbum;
  int numList = 0;
  bool avail = false;
  @override
  void initState() {
    super.initState();
    try{
      futureAlbum = fetchAlbum();

      avail = true;
    }catch(e){
      avail = false;
    }
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(CupertinoIcons.back,color: black,),
      //   actions: [Icon(CupertinoIcons.search,color: black,)],
      //   backgroundColor: primary,elevation: 0,),
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: primary, boxShadow: [
              BoxShadow(
                  color: grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3)
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(CupertinoIcons.back),
                      Icon(CupertinoIcons.search)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Coupons",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mainFontColor,
                    )),
                avail? Text("Service Available",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: mainFontColor,
                    )): Text("Service Not Available",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: mainFontColor,
                    )), 
              ],
            ),
          ),
         
         Padding(
           padding: const EdgeInsets.only(top:5,bottom: 20,left: 25,right: 20),
           child: Column(children: [
            Row(children: [
               Container(              
              padding: EdgeInsets.only(left:25,right: 25,top: 5,bottom: 5),
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(                
                  color:buttoncolor, borderRadius: BorderRadius.circular(25),
                 
                  ),
              child: Center(
                child: Text(
                  "All",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
             Container(              
              padding: EdgeInsets.only(left:25,right: 25,top: 5,bottom: 5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(                
                  color:white, borderRadius: BorderRadius.circular(25),
                   boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    )]
                  
                  ),
              child: Center(
                child: Text(
                  "Online Shopping",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
             Container(              
              padding: EdgeInsets.only(left:25,right: 25,top: 5,bottom: 5),
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(                
                  color:white, borderRadius: BorderRadius.circular(25),
                   boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    )]
                  
                  ),
              child: Center(
                child: Text(
                  "Food",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ],)
           ],),
         ),
        Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainFontColor,
                    )),
               
              ],
            ),
          ),
           Row(
  children: [
    Expanded(
      child: FutureBuilder<List<ApiConstant>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.map((album) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 25,
                    right: 25,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.03),
                        spreadRadius: 10,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, right: 20, left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Icon(
                              Icons.computer,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            width: (size.width - 90) * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  album.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Amount of Savings: ${album.savings}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${album.salePrice}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    ),
  ],
),

          //  Row(
          //         children: [
          //           Expanded(
          //             child: Container(
          //               margin: EdgeInsets.only(
          //                 top: 10,
          //                 left: 25,
          //                 right: 25,
          //               ),
          //               decoration: BoxDecoration(
          //                   color: white,
          //                   borderRadius: BorderRadius.circular(25),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: grey.withOpacity(0.03),
          //                       spreadRadius: 10,
          //                       blurRadius: 3,
          //                       // changes position of shadow
          //                     ),
          //                   ]),
          //               child: Padding(
          //                 padding: const EdgeInsets.only(
          //                     top: 10, bottom: 20, right: 20, left: 20),
          //                 child: Row(
          //                   children: [
          //                     Container(
          //                       width: 50,
          //                       height: 50,
          //                       // decoration: BoxDecoration(
          //                       //   color: arrowbgColor,
          //                       //   borderRadius: BorderRadius.circular(15),
          //                       //   // shape: BoxShape.circle
          //                       // ),
          //                       child: Center(
          //                           child: Icon(Icons.emoji_food_beverage,color: mainFontColor,)),
          //                     ),
          //                     SizedBox(
          //                       width: 10,
          //                     ),
          //                     Expanded(
          //                       child: Container(
          //                         width: (size.width - 90) * 0.7,
          //                         child: Column(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                 "In N Out",
          //                                 style: TextStyle(
          //                                     fontSize: 15,
          //                                     color: black,
          //                                     fontWeight: FontWeight.bold),
          //                               ),
          //                               SizedBox(
          //                                 height: 5,
          //                               ),
          //                               Text(
          //                                 "Santa Clara, CA",
          //                                 style: TextStyle(
          //                                     fontSize: 12,
          //                                     color: black.withOpacity(0.5),
          //                                     fontWeight: FontWeight.w400),
          //                               ),
          //                             ]),
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Container(
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.end,
          //                           children: [
          //                             Text(
          //                               "-\$5.00",
          //                               style: TextStyle(
          //                                   fontSize: 15,
          //                                   fontWeight: FontWeight.bold,
          //                                   color: black),
          //                             )
          //                           ],
          //                         ),
                                  
          //                       ),
          //                     )
          //                   ],
          //                 ),
            
          //               ),
                        
          //             ),
          //           ),
          //         ],
          //       ),
                //  Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(
                //           top: 10,
                //           left: 25,
                //           right: 25,
                //         ),
                //         decoration: BoxDecoration(
                //             color: white,
                //             borderRadius: BorderRadius.circular(25),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: grey.withOpacity(0.03),
                //                 spreadRadius: 10,
                //                 blurRadius: 3,
                //                 // changes position of shadow
                //               ),
                //             ]),
                //         child: Padding(
                //           padding: const EdgeInsets.only(
                //               top: 10, bottom: 20, right: 20, left: 20),
                //           child: Row(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 // decoration: BoxDecoration(
                //                 //   color: arrowbgColor,
                //                 //   borderRadius: BorderRadius.circular(15),
                //                 //   // shape: BoxShape.circle
                //                 // ),
                //                 child: Center(
                //                     child: Icon(Icons.emoji_food_beverage,color: mainFontColor,)),
                //               ),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Expanded(
                //                 child: Container(
                //                   width: (size.width - 90) * 0.7,
                //                   child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           "Boba Guys",
                //                           style: TextStyle(
                //                               fontSize: 15,
                //                               color: black,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           height: 5,
                //                         ),
                //                         Text(
                //                           "Santa Clara, CA",
                //                           style: TextStyle(
                //                               fontSize: 12,
                //                               color: black.withOpacity(0.5),
                //                               fontWeight: FontWeight.w400),
                //                         ),
                //                       ]),
                //                 ),
                //               ),
                //               Expanded(
                //                 child: Container(
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.end,
                //                     children: [
                //                       Text(
                //                         "-10%",
                //                         style: TextStyle(
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                             color: black),
                //                       )
                //                     ],
                //                   ),
                                  
                //                 ),
                //               )
                //             ],
                //           ),
            
                //         ),
                        
                //       ),
                //     ),
                //   ],
                // ),
                //  Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(
                //           top: 10,
                //           left: 25,
                //           right: 25,
                //         ),
                //         decoration: BoxDecoration(
                //             color: white,
                //             borderRadius: BorderRadius.circular(25),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: grey.withOpacity(0.03),
                //                 spreadRadius: 10,
                //                 blurRadius: 3,
                //                 // changes position of shadow
                //               ),
                //             ]),
                //         child: Padding(
                //           padding: const EdgeInsets.only(
                //               top: 10, bottom: 20, right: 20, left: 20),
                //           child: Row(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 // decoration: BoxDecoration(
                //                 //   color: arrowbgColor,
                //                 //   borderRadius: BorderRadius.circular(15),
                //                 //   // shape: BoxShape.circle
                //                 // ),
                //                 child: Center(
                //                     child: Icon(Icons.computer,color: mainFontColor,)),
                //               ),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Expanded(
                //                 child: Container(
                //                   width: (size.width - 90) * 0.7,
                //                   child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           "HP Notebook Professional Laptop",
                //                           style: TextStyle(
                //                               fontSize: 15,
                //                               color: black,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           height: 5,
                //                         ),
                //                         Text(
                //                           "Amazon",
                //                           style: TextStyle(
                //                               fontSize: 12,
                //                               color: black.withOpacity(0.5),
                //                               fontWeight: FontWeight.w400),
                //                         ),
                //                       ]),
                //                 ),
                //               ),
                //               Expanded(
                //                 child: Container(
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.end,
                //                     children: [
                //                       Text(
                //                         "-\$500.00",
                //                         style: TextStyle(
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                             color: black),
                //                       )
                //                     ],
                //                   ),
                                  
                //                 ),
                //               )
                //             ],
                //           ),
            
                //         ),
                        
                //       ),
                //     ),
                //   ],
                // ),

        ],
      ),
    ));
  }
}
