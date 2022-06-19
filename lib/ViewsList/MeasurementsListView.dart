
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_watcher/Models/Measurement.dart';
import 'package:workout_watcher/Views/MeasureFormView.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class MeasurementsListView extends StatefulWidget {
  _MeasurementsListView createState() => _MeasurementsListView();
}

class _MeasurementsListView extends State<MeasurementsListView> {
  List<Measurement> measurements = [];

  // initial get all measurements
  Future<void> getMeasurements() async {
    this.measurements = await FirebaseHandler.getMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Messungen"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle),
              tooltip: "Messung hinzufügen",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeasureFormView()
                    )
                )
                .then((value) => {
                  setState(() {})
                });
              },
            )
          ],
        ),
        drawer: DefaultNavigationDrawer(),
        body: Container(
            color: Colors.black,
            child: FutureBuilder(
                future: getMeasurements(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: ListView.builder(
                          itemCount: measurements.length,
                          itemBuilder: (context, index) {
                            Measurement measurement = measurements.elementAt(index);

                            return Dismissible(
                              key: Key(measurement.date.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                  color: Colors.red
                              ),
                              onDismissed: (direction) async {
                                await FirebaseHandler.deleteMeasurement(measurement);

//                                setState(() {});
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MeasureFormView(measurement: measurement)
                                      )
                                  );
                                },
                                child: Card(
                                  color: Theme.of(context).colorScheme.primary,
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Gewicht"
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                  measurement.weight.toString() + "kg"
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "KFA"
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                  measurement.kfa.toString() + "%"
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                          DateFormat("dd.MM.yyy").format(measurement.date)
                                      ),
                                    ),
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  } else {
                    return LoadingWidget();
                  }
                })
        )
    );
  }
}
