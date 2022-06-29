import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';
import 'package:workout_watcher/features/plans/bloc/plan_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_event.dart';
import 'package:workout_watcher/features/plans/bloc/plan_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_list_item.dart';

class PlanListPage extends StatefulWidget {
  const PlanListPage({Key? key}) : super(key: key);

  @override
  State<PlanListPage> createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> {
  List<Plan> plans = [];

  @override
  void initState() {
    super.initState();

    sl<PlanBloc>().add(GetAllPlansEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pläne"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add a new plans",
            onPressed: () {
              GoRouter.of(context).push("/plan/0");
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
      drawer: const DefaultNavigationDrawer(),
      body: Container(
        color: Colors.black,
        child: Center(
            child: BlocBuilder<PlanBloc, PlanState>(
                builder: (context, state) {
                  if (state.plans != null) {
                    return ListView.builder(
                        itemCount: state.plans!.length,
                        itemBuilder: (context, index) {
                          PlanModel plan = state.plans!.elementAt(index);

                          return PlanListItem(plan: plan);
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