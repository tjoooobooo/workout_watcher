import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/charts/bloc/charts_bloc.dart';
import 'package:workout_watcher/features/charts/bloc/charts_event.dart';
import 'package:workout_watcher/features/charts/bloc/charts_state.dart';

import 'data_selection_asset_image.dart';
import 'data_selection_item.dart';

class DataSelectionContainer extends StatelessWidget {
  const DataSelectionContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChartsBloc chartsBloc = sl<ChartsBloc>();

    return BlocBuilder<ChartsBloc, ChartState>(builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    chartsBloc.add(ChangedDataEvent(selectedData: ChartData.weight));
                    // selectedDataCaption = "Gewicht (kg)";
                  },
                  child: DataSelectionItem(
                      icon: FontAwesomeIcons.weightScale,
                      isSelected: state.selectedData == ChartData.weight)),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.kfa));
                  // selectedDataCaption = "Körperfett (%)";
                },
                child: DataSelectionItem(
                    icon: FontAwesomeIcons.percent,
                    isSelected: state.selectedData == ChartData.kfa),
              ),
              GestureDetector(
                  onTap: () {
                    chartsBloc.add(ChangedDataEvent(selectedData: ChartData.shoulders));
                    // selectedDataCaption = "Schulter-Umfang (cm)";
                  },
                  child: DataSelectionAssetImage(
                      name: "shoulders", isSelected: state.selectedData == ChartData.shoulders)),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.chest));
                  // selectedDataCaption = "Brust-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "chest", isSelected: state.selectedData == ChartData.chest),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.core));
                  // selectedDataCaption = "Bauch-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "core", isSelected: state.selectedData == ChartData.core),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.lArms));
                  // selectedDataCaption = "Linker Arm-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "lArms", isSelected: state.selectedData == ChartData.lArms),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.rArms));
                  // selectedDataCaption = "Rechter Arm-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "rArms", isSelected: state.selectedData == ChartData.rArms),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.butt));
                  // selectedDataCaption = "Po-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "butt", isSelected: state.selectedData == ChartData.butt),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.lQuads));
                  // selectedDataCaption = "Linker Qudarizeps-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "lQuads", isSelected: state.selectedData == ChartData.lQuads),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.rQuads));
                  // selectedDataCaption = "Rechter Qudarizeps-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "rQuads", isSelected: state.selectedData == ChartData.rQuads),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.lCalves));
                  // selectedDataCaption = "Linker Waden-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "lCalve", isSelected: state.selectedData == ChartData.lCalves),
              ),
              GestureDetector(
                onTap: () {
                  chartsBloc.add(ChangedDataEvent(selectedData: ChartData.rCalves));
                  // selectedDataCaption = "Rechter Waden-Umfang (cm)";
                },
                child: DataSelectionAssetImage(
                    name: "rCalve", isSelected: state.selectedData == ChartData.rCalves),
              ),
            ],
          ),
        ),
      );
    });
  }
}
