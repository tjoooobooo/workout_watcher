import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/navDrawer/DefaultNavDrawer.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

import 'CreatePlanMain.dart';

class PlanList extends StatefulWidget {
  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  List<Plan> plans = [];

  Future<void> getPlans() async {
    plans = await FirebaseHandler.getPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pläne"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add a new plan",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePlanMainPage(workoutPlan: null)
                  )
              ).then((value) => {
                setState(() {})
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            tooltip: "Options",
            onPressed: () {

            },
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: Container(
        color: Colors.black,
        child: Center(
            child: FutureBuilder(
                future: getPlans(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          Plan currentPlan = plans[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreatePlanMainPage(workoutPlan: currentPlan)
                                  )
                              );
                            },
                            child: Card(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                child: ListTile(
                                    leading: Icon(Icons.assignment),
                                    title: Text(currentPlan.name),
                                    trailing: Text(currentPlan.state)
                                )
                            ),
                          );
                        }
                    );
                  } else {
                    return LoadingWidget();
                  }
                }
            )
        ),
      ),
    );
  }
}