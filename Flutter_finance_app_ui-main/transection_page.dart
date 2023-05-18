import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
// A method that retrieves all the dogs from the dogs table.

class ChartData {
        ChartData(this.x, this.y);
        final String x;
        final double? y;
    }
class TransectionPage extends StatefulWidget {
  const TransectionPage({super.key});

  @override
  State<TransectionPage> createState() => _TransectionPageState();
}

class _TransectionPageState extends State<TransectionPage> {
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
    //var size = MediaQuery.of(context).size;

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
                  Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Daily Spending:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    )
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Limit:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                      backgroundColor: Colors.red
                    )
                  ),
                
              ]
            )
          ),
                  SfCartesianChart(
                    enableAxisAnimation: true,
                    
                        title: ChartTitle(text: "This year's spending vs last year"),
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(


                          title: AxisTitle(
                            text: 'Month',
                            textStyle: TextStyle(
                              color: Colors.black,
                                fontFamily: 'TimesNewRoman',
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300
                            )
                          )
                        ),
                        
                        primaryYAxis: NumericAxis(
                          interval: 5,
                          title: AxisTitle(
                            text: 'Spending',
                            textStyle: TextStyle(
                              color: Colors.black,
                                fontFamily: 'TimesNewRoman',
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300
                            )
                          )
                        ),
                        series: <ChartSeries>[
                            // Initialize line series
                            LineSeries<ChartData, String>(
                                color: Colors.red,
                                dataSource: [

                                    // Bind data source
                                    ChartData('Jan', 10),
                                    ChartData('Feb', 2),
                                    ChartData('Mar', 4),
                                    ChartData('Apr', 12),
                                    ChartData('May', 3),
                                    ChartData('Jun', 6),
                                    ChartData('Jul', 9),
                                    ChartData('Aug', 17),
                                    ChartData('Sep', 13),
                                    ChartData('Oct', 42),
                                    ChartData('Nov', 10),
                                    ChartData('Dec', 18)
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                // Render the data label
                                dataLabelSettings:DataLabelSettings(isVisible : true)
                            ),
                            LineSeries<ChartData, String>(
                                color: Colors.blue,
                                dataSource: [

                                    // Bind data source
                                    ChartData('Jan', 5),
                                    ChartData('Feb', 10),
                                    ChartData('Mar', 20),
                                    ChartData('Apr', 19),
                                    ChartData('May', 8),
                                    ChartData('Jun', 9),
                                    ChartData('Jul', 4),
                                    ChartData('Aug', 16),
                                    ChartData('Sep', 20),
                                    ChartData('Oct', 14),
                                    ChartData('Nov', 9),
                                    ChartData('Dec', 23)
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                // Render the data label
                                dataLabelSettings:DataLabelSettings(isVisible : true)
                            )
                        ]
                    ),
                    SfCartesianChart(
                        enableAxisAnimation: true,
                        title: ChartTitle(text: "This month's spending"),
                         
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          title: AxisTitle(
                            text: 'Dates',
                            textStyle: TextStyle(
                              color: Colors.black,
                                fontFamily: 'TimesNewRoman',
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300
                            )
                          )
                        ),
                        primaryYAxis: NumericAxis(
                          interval: 5,
                          title: AxisTitle(
                            text: 'Spending',
                            textStyle: TextStyle(
                              color: Colors.black,
                                fontFamily: 'TimesNewRoman',
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300
                            )
                          )
                        ),
                        
                        series: <ChartSeries>[
                            // Initialize line series
                            LineSeries<ChartData, String>(
                                dataSource: [
                                    // Bind data source
                                    ChartData('1-7', 10),
                                    ChartData('8-14', 2),
                                    ChartData('15-21', 4),
                                    ChartData('22-end of month', 12),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                // Render the data label
                               
                                dataLabelSettings:DataLabelSettings(isVisible : true)
                            )
                        ]
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),                  
        ],
      ),
    ));
  }
}
