import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:flutter_finance_app/purchase.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  // Text controllers to store values input into text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // String to store text
  String textHolder = "";

  // Var to store IDs
  static int idCounter = 0;

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

  // Destroy text controllers
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 110, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
              children: const [
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
              child: TextField(
                key: Key("nameField"),
                controller: nameController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: mainFontColor,
                  ),
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
              children: const [
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
              child: TextField(
                key: Key("priceField"),
                controller: priceController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Price',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: mainFontColor,
                  ),
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
              children: const [
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
          GestureDetector(
            key: Key("addItemButton"),
            onTap: () async {
              print("BUtton PREssed!!!\n\n\n");
              //Instantiate purchase object
              var purchase = Purchase(
                  id: idCounter,
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  category: dropDownText,
                  createdAt: DateTime.now().millisecondsSinceEpoch);
              await Database.addPurchase(purchase);

              ++idCounter;

              setState(() {
                textHolder = purchase.toString();
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: buttoncolor, borderRadius: BorderRadius.circular(25)),
              child: const Center(
                child: Text(
                  "Add Item",
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
