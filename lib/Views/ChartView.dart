import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:workout_watcher/Models/Measurement.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class ChartView extends StatefulWidget {
  @override
  State<ChartView> createState() => _ChartView();
}


class _ChartView extends State<ChartView> {
  String? selectedData;
  String selectedDataCaption = "Gewicht";

  List<DateTime> dates = [];
  List<double> values = [];

  double minX = 0;
  double? maxX;
  double? minY;
  double? maxY;

  List<FlSpot> spots = [];

  Future<void> getChartData() async {
    List<Measurement> measurements = await FirebaseHandler.getMeasurements();
    measurements = measurements.reversed.toList();

    double counter = 0;

    spots = [];
    values = [];
    dates = [];

    // collect the chart data
    measurements.forEach((measurement) {
      double value = measurement.toJSON()[selectedData ?? "weight"];

      if (value != null) {
        dates.add(measurement.date);
        values.add(value);

        spots.add(new FlSpot(counter, value));
        counter += 1;
      }
    });

    maxX = (spots.length - 1).toDouble();

    minY = values.reduce((min)) * 0.9;
    maxY = values.reduce((max)) * 1.1;
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d29a)
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Übersichten"),
          actions: <Widget>[
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0
          ),
          color: Colors.black,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(6.0),
                child: Text(
                  selectedDataCaption,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder(
                future: getChartData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (spots.length > 0) {
                      return ChartContainer(
                          minX: minX,
                          maxX: maxX,
                          minY: minY,
                          maxY: maxY,
                          dates: dates,
                          gradientColors: gradientColors,
                          spots: spots
                      );
                    } else {
                      return Container(
                          padding: EdgeInsets.all(5.0),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
                          child: Center(
                            child: Text(
                              "Keine Daten",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                      );
                    }
                  } else {
                    return Container(
                        padding: EdgeInsets.all(5.0),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.5,
                        child: LoadingWidget()
                    );
                  }
                },
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).colorScheme.primary,
                child: Text(
                  "Wähle Daten für den Graphen",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedData = "weight";
                          selectedDataCaption = "Gewicht (kg)";
                          setState(() {});
                        },
                          child: DataSelectionItem(icon: FontAwesomeIcons.weight)
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "kfa";
                          selectedDataCaption = "Körperfett (%)";
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.percentage,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "shoulders";
                          selectedDataCaption = "Schulter-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "shoulders"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "chest";
                          selectedDataCaption = "Brust-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "chest"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "core";
                          selectedDataCaption = "Bauch-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "core"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "lArms";
                          selectedDataCaption = "Linker Arm-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "lArms"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "rArms";
                          selectedDataCaption = "Rechter Arm-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "rArms"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "butt";
                          selectedDataCaption = "Po-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "butt"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "lQuads";
                          selectedDataCaption = "Linker Qudarizeps-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "lQuads"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "rQuads";
                          selectedDataCaption = "Rechter Qudarizeps-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "rQuads"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "lCalves";
                          selectedDataCaption = "Linker Waden-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "lCalve"),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedData = "rCalves";
                          selectedDataCaption = "Rechter Waden-Umfang (cm)";
                          setState(() {});
                        },
                        child: AssetImage(name: "rCalve"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}

class AssetImage extends StatelessWidget {
  final String name;

  const AssetImage({
    Key? key,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        padding: EdgeInsets.all(5),
        child: Image.asset(
          "assets/" + name + ".png",
          color: Theme.of(context).colorScheme.primary,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}

class ChartContainer extends StatelessWidget {
  const ChartContainer({
    Key? key,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.dates,
    required this.gradientColors,
    required this.spots,
  }) : super(key: key);

  final double minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final List<DateTime> dates;
  final List<Color> gradientColors;
  final List<FlSpot> spots;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      child: LineChart(
          LineChartData(
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
              titlesData: FlTitlesData(
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
// //                    rotateAngle: 90,
// //                    reservedSize: 60,
//                       showTitles: true,
//                       getTextStyles: (context, val) =>
//                           TextStyle(
//                             color: Colors.white,
//                           ),
//                       getTitles: (index) {
//                         return DateFormat('dd.MM.yyy').format(
//                             dates.elementAt(index.toInt()))
//                         ;
//                       },
//                     )
//                   ),
//                   leftTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     getTextStyles: (context, val) =>
//                         TextStyle(
//                             color: Colors.white
//                         ),
//                     getTitles: (index) {
//                       return index.toStringAsFixed(2);
//                     },
//                   ),
              ),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      strokeWidth: 1
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      strokeWidth: 1
                  );
                },
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      width: 1
                  )
              ),
              lineBarsData: [
                LineChartBarData(
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: gradientColors
                    ),
                    barWidth: 3,
                    belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColors
                        ),
                        // color: gradientColors
                        //     .map((e) => e.withOpacity(0.3))
                        //     .toList()
                    ),
                    spots: spots
                )
              ]
          )
      ),
    );
  }
}

class DataSelectionItem extends StatelessWidget {
  final IconData icon;

  const DataSelectionItem({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        padding: const EdgeInsets.all(5),
        child: FaIcon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 40,
        ),
      ),
    );
  }
}