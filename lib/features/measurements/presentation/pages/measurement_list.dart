import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_bloc.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_event.dart';
import 'package:workout_watcher/features/measurements/bloc/measurments_state.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';
import 'package:workout_watcher/Views/MeasureFormView.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class MeasurementList extends StatefulWidget {
  const MeasurementList({Key? key}) : super(key: key);

  @override
  _MeasurementsListView createState() => _MeasurementsListView();
}

class _MeasurementsListView extends State<MeasurementList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Messungen"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              tooltip: "Messung hinzufügen",
              onPressed: () {
                GoRouter.of(context).push("/measurement/0");
              },
            )
          ],
        ),
        drawer: const DefaultNavigationDrawer(),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColorDark,
              child: BlocConsumer<MeasurementsBloc, MeasurementState>(
                  listener: (context, state) {
                    if (state.status ==
                        MeasurementStateStatus.loadedMeasurement) {
                      sl<MeasurementsBloc>().add(GetAllMeasurementsEvent());
                    }
                  },
                  bloc: sl<MeasurementsBloc>()..add(GetAllMeasurementsEvent()),
                  builder: ((context, state) {
                    if (state.status == MeasurementStateStatus.loading) {
                      return const LoadingWidget();
                    } else if (state.status == MeasurementStateStatus.loaded) {
                      return MeasurementsListContainer(
                          measurements: state.measurements);
                    }

                    return Container();
                  }))),
        ));
  }
}

class MeasurementsListContainer extends StatelessWidget {
  const MeasurementsListContainer({
    Key? key,
    required this.measurements,
  }) : super(key: key);

  final List<MeasurementModel> measurements;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.925,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Container(
              height: MediaQuery.of(context).size.height * 0.975,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: measurements.length,
                    itemBuilder: (context, index) {
                      MeasurementModel measurement =
                          measurements.elementAt(index);

                      return Dismissible(
                        key: Key(measurement.date.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          sl<MeasurementsBloc>()
                              .add(DeleteMeasurementEvent(measurement.id!));
                        },
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .push("/measurement/${measurement.id}");
                          },
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "KFA",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Gewicht",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        measurement.kfa.toString() + " %",
                                        style:
                                        const TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        measurement.weight.toString() + " kg",
                                        style:
                                        const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              trailing: Text(
                                DateFormat("dd.MM.yyy").format(measurement.date),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
