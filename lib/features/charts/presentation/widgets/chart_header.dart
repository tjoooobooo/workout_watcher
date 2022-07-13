import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/charts/bloc/charts_bloc.dart';
import 'package:workout_watcher/features/charts/bloc/charts_state.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartsBloc, ChartState>(
        builder: (context, state) {
          String caption = "";
          switch (state.selectedData) {
            case ChartData.weight:
              caption = "Gewicht (kg)";
              break;
            case ChartData.kfa:
              caption = "Körperfett (%)";
              break;
            case ChartData.shoulders:
              caption = "Schulterumfang (cm)";
              break;
            case ChartData.chest:
              caption = "Brustumfang (cm)";
              break;
            case ChartData.core:
              caption = "Bauchumfang (cm)";
              break;
            case ChartData.lArms:
              caption = "linker Armumfang (cm)";
              break;
            case ChartData.rArms:
              caption = "rechter Armumfang (cm)";
              break;
            case ChartData.butt:
              caption = "Gluteusumfang (cm)";
              break;
            case ChartData.lQuads:
              caption = "linker Quadrizepsumfang (cm)";
              break;
            case ChartData.rQuads:
              caption = "rechter Quadrizepsumfang (cm)";
              break;
            case ChartData.lCalves:
              caption = "linker Wadenumfang (cm)";
              break;
            case ChartData.rCalves:
              caption = "rechter Wadenumfang (cm)";
              break;
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(6.0),
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          );
        }
    );
  }
}