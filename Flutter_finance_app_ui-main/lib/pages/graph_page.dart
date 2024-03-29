import 'package:flutter/material.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:flutter_finance_app/database.dart';
import 'package:flutter_finance_app/purchase.dart';
import 'package:flutter_finance_app/data_point.dart';
import 'package:flutter_finance_app/database_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  // List to store database data
  // List<Purchase> purchaseData = <Purchase>[];

  DatabaseData purchaseData = DatabaseData();
  List<Purchase> dailyData = <Purchase>[];
  List<DataPoint> rangeData = <DataPoint>[];

  // List to store graph time period options
  String timeDropDownText = "Week";
  List<String> timeDropDownItems = [
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

  late TooltipBehavior _tooltipBehaviorDaily;
  late TooltipBehavior _tooltipBehaviorRange;

  @override
  void initState() {
    _tooltipBehaviorDaily =
        TooltipBehavior(enable: true, format: '\$point.y', header: 'Purchase');
    _tooltipBehaviorRange =
        TooltipBehavior(enable: true, format: '\$point.y', header: 'Purchases');
    buildDataSet();
    super.initState();
  }

  // Refreshes data set used for building graphs
  // Called when dropdown changes
  buildDataSet() async {
    rangeData.clear();
    dailyData.clear();

    // Build data for dailyData
    DateTime now = new DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day);

    // For each purchase in database
    for (int i = 0; i < purchaseData.data.length; ++i) {
      DateTime itemDate =
          DateTime.fromMillisecondsSinceEpoch(purchaseData.data[i].createdAt);

      if (itemDate.day == currentDate.day &&
          itemDate.month == currentDate.month) {
        Purchase temp = purchaseData.data[i];
        dailyData.add(temp);
      }
    }

    // Build data for rangeData
    if (timeDropDownText == 'Year') {
      // Create datapoint for each month
      for (int i = 1; i < 13; ++i) {
        DataPoint temp =
            DataPoint(price: 0, category: "", createdAt: 0, time: i);

        rangeData.add(temp);
      }

      // Add up expenditures for each month
      for (Purchase item in purchaseData.data) {
        if (item.year == now.year) {
          if (categoryDropDownText == "Food" && item.category == "Food")
            rangeData[item.month].price += item.price;
          else if (categoryDropDownText == "Utilities" &&
              item.category == "Utilities")
            rangeData[item.month].price += item.price;
          else if (categoryDropDownText == "All")
            rangeData[item.month].price += item.price;
        }
      }
    } else if (timeDropDownText == "Month") {
      // // Create datapoint for each week
      // for (int i = 1; i < 5; ++i) {
      //   DataPoint temp =
      //       DataPoint(price: 0, category: "", createdAt: 0, time: i);

      //   rangeData.add(temp);
      // }
    } else if (timeDropDownText == "Week") {
      // Create datapoint for each month
      for (int i = 1; i < 8; ++i) {
        DataPoint temp =
            DataPoint(price: 0, category: "", createdAt: 0, time: i);

        rangeData.add(temp);
      }

      DateTime mostRecentMonday =
          DateTime(now.year, now.month, now.day - (now.weekday - 1));

      // Select only purchases during current week
      for (Purchase item in purchaseData.data) {
        if (item.month == currentDate.month) {
          if (item.day >= mostRecentMonday.day &&
              item.day <= mostRecentMonday.add(const Duration(days: 7)).day) {
            if (categoryDropDownText == "Food" && item.category == "Food")
              rangeData[item.day - mostRecentMonday.day].price += item.price;
            else if (categoryDropDownText == "Utilities" &&
                item.category == "Utilities")
              rangeData[item.day - mostRecentMonday.day].price += item.price;
            else if (categoryDropDownText == "All")
              rangeData[item.day - mostRecentMonday.day].price += item.price;
          }
        }
      }
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
                  padding: EdgeInsets.only(left: 20, bottom: 40),
                  child: Text("Options:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: mainFontColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 40),
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
                        buildDataSet();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 40),
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
                        buildDataSet();
                      });
                    },
                  ),
                ),
              ],
            ),

            // Graph ---------------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
              child: SfCartesianChart(
                title: ChartTitle(text: 'Spending Trends'),
                tooltipBehavior: _tooltipBehaviorRange,
                primaryXAxis: CategoryAxis(),
                // ChartSeries?
                series: <LineSeries<DataPoint, int>>[
                  LineSeries<DataPoint, int>(
                      animationDuration: 2500,
                      // Binding list data to the chart.
                      dataSource: rangeData,
                      xValueMapper: (DataPoint point, _) => point.time,
                      yValueMapper: (DataPoint point, _) => point.price,
                      markerSettings: MarkerSettings(isVisible: true)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
              child: SfCartesianChart(
                title: ChartTitle(text: 'Daily Spending'),
                tooltipBehavior: _tooltipBehaviorDaily,
                primaryXAxis: CategoryAxis(),
                // ChartSeries?
                series: <LineSeries<Purchase, String>>[
                  LineSeries<Purchase, String>(
                      animationDuration: 2500,
                      // Binding list data to the chart.
                      dataSource: dailyData,
                      xValueMapper: (Purchase item, _) => DateFormat.Hm()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              item.createdAt)),
                      yValueMapper: (Purchase item, _) => item.price,
                      markerSettings: MarkerSettings(isVisible: true)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
