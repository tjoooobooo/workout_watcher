import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/charts/bloc/charts_bloc.dart';
import 'package:workout_watcher/features/charts/bloc/charts_state.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_bloc.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_event.dart';
import 'package:workout_watcher/features/measurements/bloc/measurments_state.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';

class ChartContainer extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6).withOpacity(0.4),
    const Color(0xff02d29a).withOpacity(0.4)
  ];

  final List<FlSpot> spots = [];
  final List<DateTime> dates = [];
  final List<double> values = [];

  ChartContainer({
    Key? key,
  }) : super(key: key);

  double minX = 0;
  double? maxX;
  double? minY;
  double? maxY;

  void getChartData(ChartData selectedData) {
    List<MeasurementModel> measurements = sl<MeasurementsBloc>().state.measurements;
    measurements = measurements.reversed.toList();

    if (measurements.isNotEmpty) {
      double counter = 0;

      spots.clear();
      values.clear();
      dates.clear();

      // collect the chart data
      for (var measurement in measurements) {
        double? value = measurement.toJSON()[selectedData.name];

        if (value != null) {
          dates.add(measurement.date);
          values.add(value);

          spots.add(FlSpot(counter, value));
          counter += 1;
        }
      }

      if (values.isNotEmpty) {
        maxX = (spots.length - 1).toDouble();
        minY = values.reduce((min)) * 0.9;
        maxY = values.reduce((max)) * 1.1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementsBloc, MeasurementState>(
      bloc: sl<MeasurementsBloc>()..add(GetAllMeasurementsEvent()),
      builder: (context, state) {
        if (state.status.isLoading) {
          return const LoadingWidget();
        } else {
          return Container(
            padding: const EdgeInsets.all(15.0),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            child: BlocBuilder<ChartsBloc, ChartState>(
                builder: (context, state) {
                  getChartData(state.selectedData);

                  if (spots.isNotEmpty) {
                    return LineChart(LineChartData(
                        minX: minX,
                        maxX: maxX,
                        minY: minY,
                        maxY: maxY,
                        titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 60,
                                    getTitlesWidget: (index, meta) {
                                      return Text(index.toStringAsFixed(2));
                                    })),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 70,
                                    getTitlesWidget: (index, meta) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Text(DateFormat('dd.MM.yy')
                                                .format(dates.elementAt(index.toInt())))),
                                      );
                                    })),
                            rightTitles: AxisTitles(),
                            topTitles: AxisTitles()),
                        gridData: FlGridData(
                          show: true,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(color: Colors.white, strokeWidth: 1);
                          },
                          getDrawingVerticalLine: (value) {
                            return FlLine(color: Colors.white, strokeWidth: 1);
                          },
                        ),
                        borderData:
                        FlBorderData(show: true, border: Border.all(color: Colors.white, width: 1)),
                        lineBarsData: [
                          LineChartBarData(
                              isCurved: true,
                              gradient: LinearGradient(colors: gradientColors),
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(colors: gradientColors),
                              ),
                              spots: spots)
                        ]));
                  } else {
                    return Container(
                        padding: const EdgeInsets.all(5.0),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white
                          )
                        ),
                        child: const Center(
                          child: Text(
                            "Keine Daten",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ));
                  }
                }),
          );
        }
      }
    );
  }
}
