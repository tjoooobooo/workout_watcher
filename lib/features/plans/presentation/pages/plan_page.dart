import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_dropdown_row.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';
import 'package:workout_watcher/core/presentation/widgets/section_header_container.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/plan_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_event.dart';
import 'package:workout_watcher/features/plans/bloc/plan_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

class PlanPage extends StatefulWidget {
  final String planId;

  const PlanPage({Key? key, required this.planId}) : super(key: key);

  @override
  _PlanPage createState() => _PlanPage();
}

class _PlanPage extends State<PlanPage> {
  final TextEditingController nameCtrl = TextEditingController();
  PlanCreateBloc planCreateBloc = sl<PlanCreateBloc>();

  int chosenCyclesCount = 4;
  int chosenDaysCount = 4;

  @override
  void initState() {
    super.initState();
    if (widget.planId != "0") {
      sl<PlanBloc>().add(GetPlanEvent(widget.planId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Plan erstellen"),
        ),
        body: SingleChildScrollView(
          child: BlocListener<PlanBloc, PlanState>(
            listener: (context, state) {
              if (state.status.isLoadedPlan) {
                nameCtrl.text = state.plan!.name;
                chosenDaysCount = state.plan!.units;
                chosenCyclesCount = state.plan!.cycles;

                planCreateBloc.add(StartedEditingEvent(plan: state.plan!));
                setState(() {});
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).primaryColorDark,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.825,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.925,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                IconLabelTextRow(
                                  iconData: Icons.abc_rounded,
                                  label: "Name",
                                  controller: nameCtrl,
                                  onChanged: (value) => planCreateBloc
                                      .add(UpdatePlanCreateEvent(name: nameCtrl.text)),
                                ),
                                IconLabelDropdownRow(
                                    iconData: FontAwesomeIcons.calendarDay,
                                    label: "Einheiten",
                                    initialType: chosenDaysCount,
                                    items: const {
                                      1: "1 Tag",
                                      2: "2 Tage",
                                      3: "3 Tage",
                                      4: "4 Tage",
                                      5: "5 Tage",
                                      6: "6 Tage",
                                      7: "7 Tage"
                                    },
                                    changeValueFunc: (value) {
                                      chosenDaysCount = value;
                                      planCreateBloc.add(UpdatePlanCreateEvent(units: value));
                                    }),
                                IconLabelDropdownRow(
                                    iconData: FontAwesomeIcons.calendar,
                                    label: "Dauer",
                                    initialType: chosenCyclesCount,
                                    items: const {
                                      1: "1 Zyklus",
                                      2: "2 Zyklen",
                                      3: "3 Zyklen",
                                      4: "4 Zyklen",
                                      5: "5 Zyklen",
                                      6: "6 Zyklen",
                                      7: "7 Zyklen",
                                      8: "8 Zyklen"
                                    },
                                    changeValueFunc: (value) {
                                      chosenCyclesCount = value;
                                      planCreateBloc.add(UpdatePlanCreateEvent(cycles: value));
                                    }),
                              ],
                            ),
                          ),
                          const SectionHeaderContainer(header: "Einstellungen"),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.925,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(children: [
                                IconLabelTextRow(
                                    iconData: Icons.abc_rounded,
                                    label: "Name",
                                    controller: nameCtrl),
                              ]))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.925,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: BlocListener<PlanBloc, PlanState>(
                      listener: (context, state) {
                        if (state.status.isAdded || state.status.isUpdated) {
                          GoRouter.of(context).push("/plan-day/${state.plan?.id}");
                        }
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          PlanModel? statePlan = sl<PlanBloc>().state.plan;
                          var state = sl<PlanBloc>().state.status;

                          if (statePlan != null) {
                            PlanModel plan = statePlan.copyWith(
                              name: nameCtrl.text,
                              cycles: chosenCyclesCount,
                              units: chosenDaysCount
                            );

                            sl<PlanBloc>().add(UpdatePlanEvent(plan));
                          } else {
                            PlanModel plan = PlanModel(
                                name: nameCtrl.text,
                                cycles: chosenCyclesCount,
                                units: chosenDaysCount);

                            sl<PlanBloc>().add(AddPlanEvent(plan));
                          }
                        },
                        child: const Text(
                          "Weiter",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
