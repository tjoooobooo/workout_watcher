import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Plan/CreatePlanMain.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/features/plan/presentation/widgets/plan_list_item.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class PlanListPage extends StatefulWidget {
  @override
  State<PlanListPage> createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> {
  List<Plan> plans = [];

  Future<void> getPlans() async {
    plans = await FirebaseHandler.getPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pläne"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
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
            icon: const Icon(Icons.more_vert),
            tooltip: "Options",
            onPressed: () {

            },
          ),
        ],
      ),
      drawer: DefaultNavigationDrawer(),
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

                          return PlanListItem(currentPlan: currentPlan);
                        }
                    );
                  } else {
                    return const LoadingWidget();
                  }
                }
            )
        ),
      ),
    );
  }
}