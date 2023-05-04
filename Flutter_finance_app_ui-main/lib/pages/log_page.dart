import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  // List to store items in dropdown menu
  String dropDownText = "Food";
  List<String> dropDownItems = [
    "Food",
    "Shopping",
    "Textbooks",
    "Utilities",
    "Other",
  ];

  // Constructor
  _LogPageState() {
    // set dropDownText to default value
    dropDownText = dropDownItems.elementAt(0);
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
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 110, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Log Purchase",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),

          // Item Name -------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Item:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Item',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          // Price -------------------------------------------------------

          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          // Category ---------------------------------------------------

          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: DropdownButton(
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

          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: buttoncolor, borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Text(
                "Add Item",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
