import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_button_row.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_dropdown_row.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_switch_row.dart';
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

  int chosenCyclesCount = 4;
  int chosenDaysCount = 4;

  @override
  void initState() {
    super.initState();
    if (widget.planId != "0") {
      sl<PlanBloc>().add(GetPlanEvent(widget.planId));
    }
  }

  Future<String?> openCloseDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceAround,
            actionsOverflowDirection: VerticalDirection.down,
            actionsOverflowButtonSpacing: 2,
            backgroundColor: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Column(
              children: [
                const Text("Plan bearbeitung beenden"),
                Divider(color: Theme.of(context).primaryColorDark, thickness: 2.0)
              ],
            ),
            content: const Text("Schließen ohne zu speichern?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop("save");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  child: const Text("Speichern", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop("back");
                  },
                  style:
                      ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
                  child: const Text("Zurück", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop("cancel");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  child: const Text("Abbrechen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
            ],
          );
        });
  }

  Future<bool?> openDeleteDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            backgroundColor: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Column(
              children: [
                const Text("Plan löschen?"),
                Divider(color: Theme.of(context).primaryColorDark, thickness: 2.0)
              ],
            ),
            content: const Text("Bist du sicher, dass du den Plan endgültig löschen willst?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style:
                      ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
                  child: const Text("Löschen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  child: const Text("Abbrechen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
            ],
          );
        });
  }

  // on pop function
  Future<bool> onPop() async {
    // TODO before opening dialog check if plan was edited

    switch (await openCloseDialog()) {
      case "save":
        sl<PlanBloc>().add(UpdatePlanEvent(sl<PlanCreateBloc>().state.plan!));
        break;
      case "back":
        // no specific action required
        break;
      case "cancel":
      case null:
        return false;
    }

    sl<PlanBloc>().add(GetAllPlansEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool isPlanExistent = false;

    for (var plan in sl<PlanBloc>().state.plans!) {
      if (plan.id == widget.planId) {
        isPlanExistent = true;
      }
    }

    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Plan erstellen"),
            actions: [
              IconButton(
                  onPressed: () {
                    sl<PlanBloc>().add(UpdatePlanEvent(sl<PlanCreateBloc>().state.plan!));
                    sl<PlanBloc>().add(GetAllPlansEvent());
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.save)),
              isPlanExistent
                  ? IconButton(
                      onPressed: () {
                        openDeleteDialog().then((shouldDeletePlan) {
                          if (shouldDeletePlan != null && shouldDeletePlan) {
                            sl<PlanBloc>().add(DeletePlanEvent(widget.planId));
                            sl<PlanBloc>().add(GetAllPlansEvent());
                            GoRouter.of(context).pop();
                          }
                        });
                      },
                      icon: Icon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.red.shade400,
                      ))
                  : Container(),
            ],
          ),
          body: SingleChildScrollView(
            child: BlocListener<PlanBloc, PlanState>(
              listener: (context, state) {
                if (state.status.isLoadedPlan) {
                  nameCtrl.text = state.plan!.name;
                  chosenDaysCount = state.plan!.units;
                  chosenCyclesCount = state.plan!.cycles;

                  sl<PlanCreateBloc>().add(StartedEditingEvent(plan: state.plan!));
                  setState(() {});
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColorDark,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
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
                                    onChanged: (value) => sl<PlanCreateBloc>()
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
                                        sl<PlanCreateBloc>()
                                            .add(UpdatePlanCreateEvent(units: value));
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
                                        sl<PlanCreateBloc>()
                                            .add(UpdatePlanCreateEvent(cycles: value));
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
                                  const IconLabelSwitchRow(
                                    iconData: Icons.abc_rounded,
                                    label: "TODO RPE",
                                  ),
                                  IconLabelButtonRow(
                                    iconData: FontAwesomeIcons.calendarWeek,
                                    label: "Wochen anpassen",
                                    buttonLabel: "Konfigurieren",
                                    onPressed: () {
                                      GoRouter.of(context).push("/plan-week");
                                    },
                                  ),
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
                            GoRouter.of(context).push("/plan-day");
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
                                  units: chosenDaysCount);

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
          )),
    );
  }
}
