import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';
import 'package:workout_watcher/features/charts/bloc/charts_bloc.dart';
import 'package:workout_watcher/features/charts/bloc/charts_event.dart';
import 'package:workout_watcher/features/charts/bloc/charts_state.dart';
import 'package:workout_watcher/features/charts/presentation/widgets/chart_container.dart';
import 'package:workout_watcher/features/charts/presentation/widgets/chart_header.dart';
import 'package:workout_watcher/features/charts/presentation/widgets/data_selection_container.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPage();
}

class _ChartPage extends State<ChartPage> {
  @override
  void initState() {
    super.initState();

    sl<ChartsBloc>().add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Übersichten")
        ),
        drawer: const DefaultNavigationDrawer(),
        body: Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          color: Colors.black,
          child: Column(
            children: [
              const DataSelectionContainer(),
              const SizedBox(height: 10),
              const ChartHeader(),
              const SizedBox(height: 10),
              ChartContainer()
            ],
          ),
        ));
  }
}