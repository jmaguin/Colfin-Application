import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_finance_app/purchase.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:icon_badge/icon_badge.dart';
import  'package:intl/intl.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:flutter_finance_app/pages/data_constant.dart';
import 'package:flutter_finance_app/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_finance_app/pages/notification.dart';
import 'package:flutter_finance_app/main.dart';
import 'package:flutter_finance_app/pages/graph_page.dart';


class DailyPage extends StatefulWidget {
  const DailyPage({super.key});
  
  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  // final NotificationService nm = NotificationService();
  String _name = '';
  String _role = '';
  String _email = '';
  double _fund = 0;
  void initState() {
    super.initState();
    loadData();
    //calcPrice();
    print(futureAlbumList.length);
    avail = true;

  }

  //late Future<List<DataObj>> futureAlbum;
  Future<void> loadData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('profileName')?? "No Data";
      _role = prefs.getString('profileRole')?? "No Data";
      _email = prefs.getString('profileEmail')?? "No Data";
      _fund = prefs.getDouble('profileFund')?? 0;
    });
  } 
  

  late List<DataObj> futureAlbumList = [];
  Future<List<DataObj>> futureAlbum = convertPurchaseList();
  double countPrice = 0;
  // double totalPrice = 0.0;
  // void calcPrice() async{
  //   futureAlbumList = await futureAlbum;
  //   for (int i = 0; i < futureAlbumList.length; i++){
  //     totalPrice += futureAlbumList[i].price;
  //   }
  // }
  
  bool avail = false;
  @override
  
  
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    String cdate3 = DateFormat("MMM dd, yyyy").format(DateTime.now());
    
    Map iconsList = Map<String, Icons>();
    iconsList = {"Receive" : Icons.arrow_downward, "Send" : Icons.arrow_upward};

    Future<void> navigateToSettPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettPage(),
      ),
    );
    if (ModalRoute.of(context)?.isCurrent == false) {
      print("refreshed");
      setState(() {
        futureAlbum = convertPurchaseList();
      });
    }
  }
  Future<void> navigateToGraphPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GraphPage(),
      ),
    );
  }
    
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.03),
                    spreadRadius: 10,
                    blurRadius: 3,
                    // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                    GestureDetector(
                        onTap: navigateToGraphPage,
                        child: Icon(Icons.bar_chart),
                        key: Key('bar'),
                    ),
                    GestureDetector(
                        onTap: navigateToSettPage,
                        child: Icon(Icons.more_vert),
                        key: Key('Settings'),
                      ),]
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: new AssetImage('assets/test.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          children: [
                            Text(
                              "$_name",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: mainFontColor),
                                  key: Key('name'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "$_role",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: black),
                                  key: Key('role'),
                            ),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
  height: 40,
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    FutureBuilder<List<DataObj>>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          final dataList = snapshot.data!;
          double totalPrice = dataList.fold<double>(
            0,
            (previousValue, dataObj) => previousValue + dataObj.price,
          );
          // countPrice = totalPrice;

          print(_fund);
          final double expense = totalPrice;
          final double cashAvailable = _fund - expense;
          final double expenseThreshold = 0.8;
          if (expense >= expenseThreshold * cashAvailable) {
            nm.showNotification();
          }

          return Column(
            children: [
              Text(
                '\$${totalPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: mainFontColor,
                ),
                key: Key('expense'),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Expenses',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                  color: black,
                ),
              ),
            ],
          );

        }
      },
    ),



    FutureBuilder<List<DataObj>>(
      future: futureAlbum,
      builder: (context, snapshot) {
        // Existing code...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        }
        else {
          final dataList = snapshot.data!;
          double countPrice = dataList.fold<double>(
            0,
            (previousValue, dataObj) => previousValue + dataObj.price,
          );

          // Existing code...

          double cashAvailable = _fund - countPrice; // Update cashAvailable here

          return Row(
            children: [
              // Container(
              //   width: 0.5,
              //   height: 40,
              //   color: black.withOpacity(0.3),
              // ),
              Column(
                children: [
                  Text(
                    "\$${cashAvailable.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: mainFontColor,
                    ),
                    key: Key('CashAvail'),
                  ),
                  SizedBox(
                    height: 5,
                  
                  ),
                  Text(
                    "Cash Available",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: black,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    ),







    // Container(
    //   width: 0.5,
    //   height: 40,
    //   color: black.withOpacity(0.3),
    // ),
    // Column(
    //   children: [
    //     Text(
    //       "\$${(_fund - countPrice).toStringAsFixed(0)}",
    //       style: TextStyle(
    //         fontSize: 16,
    //         fontWeight: FontWeight.w600,
    //         color: mainFontColor,
    //       ),
    //       key: Key('CashAvail'),
    //     ),
    //     SizedBox(
    //       height: 5,
    //     ),
    //     Text(
    //       "Cash Available",
    //       style: TextStyle(
    //         fontSize: 12,
    //         fontWeight: FontWeight.w100,
    //         color: black,
    //       ),
    //     ),
    //   ],
    // ),

    
  ],
),









                  // SizedBox(
                  //   height: 50,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text(
                  //           "\$${totalPrice}",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: mainFontColor),
                  //         ),
                  //         SizedBox(
                  //           height: 5,
                  //         ),
                  //         Text(
                  //           "Expenses",
                  //           style: TextStyle(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w100,
                  //               color: black),
                  //         ),
                  //       ],
                  //     ),
                  //     Container(
                  //       width: 0.5,
                  //       height: 40,
                  //       color: black.withOpacity(0.3),
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text(
                  //           "\$5500",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: mainFontColor),
                  //         ),
                  //         SizedBox(
                  //           height: 5,
                  //         ),
                  //         Text(
                  //           "Cash Available",
                  //           style: TextStyle(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w100,
                  //               color: black),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                         Text("Overview",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainFontColor,
                    )),
                    IconBadge(
        icon: Icon(Icons.notifications_none),
        itemCount: 1,
        badgeColor: Colors.red,
        itemColor: mainFontColor,
        hideZero: true,
        top: -1,
        onTap: () {
          print('test');
        },
      ),
                      ],
                    )
                  ],
                ),
                // Text("Overview",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //       color: mainFontColor,
                //     )),
                Text(cdate3,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),


    






          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<DataObj>>(
                        future: futureAlbum,
                        builder: (context, snapshot){
                          if (snapshot.hasData){
                            return Column(
          children: snapshot.data!.map((dataObj) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 25,
                      right: 25,
                    ),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 20,
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: arrowbgColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Icon(Icons.arrow_upward_rounded),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              width: (size.width - 90) * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sent",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Items: ${dataObj.name} Category: ${dataObj.category}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black.withOpacity(0.5),
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
                                    "-\$${dataObj.price}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        );
                          }
                          else if  (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          }
                          else{
                            return CircularProgressIndicator();
                          }
                        }
                        
                      ),
                    )
                            ],
                          ),
              ],
                        ),
                      ),
                    
                // SizedBox(
                //   height: 5,
                // ),
                // Row(
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
                //               top: 10, bottom: 10, right: 20, left: 20),
                //           child: Row(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 decoration: BoxDecoration(
                //                   color: arrowbgColor,
                //                   borderRadius: BorderRadius.circular(15),
                //                   // shape: BoxShape.circle
                //                 ),
                //                 child: Center(
                //                     child: Icon(Icons.book)),
                //               ),
                //               SizedBox(
                //                 width: 15,
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
                //                           "Subscription",
                //                           style: TextStyle(
                //                               fontSize: 15,
                //                               color: black,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           height: 5,
                //                         ),
                //                         Text(
                //                           "Subscription fee to Netflix",
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
                //                         "\$250",
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
                // SizedBox(
                //   height: 5,
                // ),
                // Row(
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
                //               top: 10, bottom: 10, right: 20, left: 20),
                //           child: Row(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 decoration: BoxDecoration(
                //                   color: arrowbgColor,
                //                   borderRadius: BorderRadius.circular(15),
                //                   // shape: BoxShape.circle
                //                 ),
                //                 child: Center(
                //                     child: Icon(CupertinoIcons.money_dollar)),
                //               ),
                //               SizedBox(
                //                 width: 15,
                //               ),
                //               Expanded(
                //                 child: Container(
                //                   width: (size.width - 90) * 0.7,
                //                   child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           "Salary",
                //                           style: TextStyle(
                //                               fontSize: 15,
                //                               color: black,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           height: 5,
                //                         ),
                //                         Text(
                //                           "Salary from Apple",
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
                //                         "\$2000",
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
          )
        
      );
  }

}
