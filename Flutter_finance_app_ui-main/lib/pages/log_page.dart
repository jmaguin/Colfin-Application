import 'package:flutter/material.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:flutter_finance_app/purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'package:flutter_finance_app/pages/data_constant.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  Future<List<DataObj>> futureAlbum = convertPurchaseList();
  // Text controllers to store values input into text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // String to store text
  String textHolder = "";

  // List to store items in dropdown menu
  String dropDownText = "Food";
  List<String> dropDownItems = [
    "Select Category",
    "Food",
    "Shopping",
    "Textbooks",
    "Utilities",
    "Other",
    "Received Funds",
    "Sent Funds",
  ];

  // Constructor
  _LogPageState() {
    // set dropDownText to default value
    dropDownText = dropDownItems.elementAt(0);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   leading: Icon(CupertinoIcons.back,color: black,),
  //     //   actions: [Icon(CupertinoIcons.search,color: black,)],
  //     //   backgroundColor: primary,elevation: 0,),
  //     // backgroundColor: primary,

  //     body: getBody(),
  //   );
  // }

  @override
Widget build(BuildContext context) {
  return new Scaffold(
    body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/3 ,
          decoration: BoxDecoration(
            color: settBack,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(
                MediaQuery.of(context).size.width+10000,
                MediaQuery.of(context).size.width+6000,
              ),
              bottomRight: Radius.elliptical(
                MediaQuery.of(context).size.width+10000,
                MediaQuery.of(context).size.width+6000,
              ),
            ),
          ),
        ),
        Container(
          child: getBody(),
        ),
      ],
  )
  );
}

  // Destroy text controllers
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Widget getBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          // const SizedBox(
          //   height: 40,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25,top: 100, bottom: 20),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Add Purchase",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: white,

                    )),
              ],
            ),
          ),

          // Item Name -------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 20),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text("Item:",
            //         key: Key("itemText"),
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 25,
            //           color: mainFontColor,
            //         )),
            //   ],
            // ),

          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: TextField(
                key: const Key("nameField"),
                controller: nameController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'item name',
                  hintStyle: TextStyle(
                    // fontWeight: FontWeight.normal,
                    // fontSize: 17,
                    // color: black,
                  ),
                ),
              ),
            ),
          ),

          // Price -------------------------------------------------------

          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 20),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text("Price:",
            //         key: Key("priceText"),
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 25,
            //           color: mainFontColor,
            //         )),
            //   ],
            // ),

          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: TextField(
                key: const Key("priceField"),
                controller: priceController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Price',
                  hintStyle: TextStyle(
                    // fontWeight: FontWeight.bold,
                    // fontSize: 20,
                    // color: mainFontColor,
                  ),
                ),
              ),
            ),
          ),

          // Category ---------------------------------------------------

          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 20),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text("Category:",
            //         key: Key("categoryText"),
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 25,
            //           color: mainFontColor,
            //         )),
            //   ],
            // ),

          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: DropdownButton(
                key: Key("dropdownButtonText"),
                // Intialize dropdown item
                value: dropDownText,
                // Set Icon for dropdown
                icon: const Icon(Icons.keyboard_arrow_down),

                // List of dropdown items
                items: dropDownItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),

                // Update after item selected
                onChanged: (String? newValue) {
                  // Refresh widget state
                  setState(() {
                    dropDownText = newValue!;
                  });
                },
              ),
            ),
          ),
          // Add item Button --------------------------------------------------
          GestureDetector(
            key: const Key("addItemButton"),
            onTap: () async {
              // Get item count
              final prefs = await SharedPreferences.getInstance();
              final itemCount = prefs.getInt('itemCount') ?? 0;

              DateTime now = DateTime.now();
              //Instantiate purchase object
              var purchase = Purchase(
                  id: itemCount,
                  name: nameController.text,
                  price: double.parse(priceController.text).toDouble(),
                  category: dropDownText,
                  createdAt: now.millisecondsSinceEpoch,
                  year: now.year,
                  month: now.month,
                  day: now.day,
                  weekday: DateFormat('EEEE').format(now));

              await Database.addPurchase(purchase);

              setState(() {
                textHolder = purchase.toString();
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              height: 60,
              decoration: BoxDecoration(
                  color: buttoncolor, borderRadius: BorderRadius.circular(25)),
              child: const Center(
                child: Text(
                  "Add Item",
                  key: Key("addItemText"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // Text to display
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(textHolder,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),
          
          
        ],
      ),
    ));
  }
}
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = settBack;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}