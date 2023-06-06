import 'package:flutter/material.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:flutter_finance_app/purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  // List to store database data
  late List<Purchase> purchaseData;

  // List to store graph time period options
  String timeDropDownText = "Year";
  List<String> timeDropDownItems = [
    "Day",
    "Week",
    "Month",
    "Year",
  ];

  // List to store graph category options
  String categoryDropDownText = "All";
  List<String> categoryDropDownItems = [
    "All",
    "Food",
    "Shopping",
    "Textbooks",
    "Utilities",
    "Other",
    "Received Funds",
    "Sent Funds",
  ];

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() async {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // Get data from database
    purchaseData = await Database.getPurchases();
    super.initState();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110, right: 25, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Visualization",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mainFontColor,
                      )),
                ],
              ),
            ),

            // Dropdown ---------------------------------------------------

            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Options:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: mainFontColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: DropdownButton(
                    alignment: Alignment.bottomCenter,
                    // Intialize dropdown item
                    value: timeDropDownText,
                    // Set Icon for dropdown
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // List of dropdown items
                    items: timeDropDownItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),

                    // Update after item selected
                    onChanged: (String? newValue) async {
                      // Refresh widget state
                      setState(() {
                        timeDropDownText = newValue!;
                      });

                      purchaseData = await Database.getPurchaseRange(
                          categoryDropDownText, timeDropDownText);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: DropdownButton(
                    alignment: Alignment.bottomCenter,
                    // Intialize dropdown item
                    value: categoryDropDownText,
                    // Set Icon for dropdown
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // List of dropdown items
                    items: categoryDropDownItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),

                    // Update after item selected
                    onChanged: (String? newValue) async {
                      // Refresh widget state
                      setState(() {
                        categoryDropDownText = newValue!;
                      });
                      purchaseData = await Database.getPurchaseRange(
                          categoryDropDownText, timeDropDownText);
                    },
                  ),
                ),
              ],
            ),

            // Graph ---------------------------------------------------

            Center(
              child: SfCartesianChart(
                title: ChartTitle(text: 'Spending Trends'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                primaryXAxis: CategoryAxis(),
                // ChartSeries?
                series: <LineSeries<Purchase, String>>[
                  LineSeries<Purchase, String>(
                    animationDuration: 2500,
                    // Binding list data to the chart.
                    dataSource: purchaseData,
                    xValueMapper: (Purchase data, _) => data.weekday,
                    yValueMapper: (Purchase data, _) => data.price,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
