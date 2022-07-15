import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Dialog/AddExceptionalExerciseDialog.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_exception_exercise_selection_page.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_week_model.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_exception_exercise_item.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_week_text_input.dart';

class PlanWeekPage extends StatelessWidget {
  PlanWeekPage({Key? key}) : super(key: key);

  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> isoWdhControllers = [];
  final List<TextEditingController> isoSetsControllers = [];
  final List<TextEditingController> isoRpeControllers = [];
  final List<TextEditingController> comWdhControllers = [];
  final List<TextEditingController> comSetsControllers = [];
  final List<TextEditingController> comRpeControllers = [];
  final ScrollController scrollController = ScrollController();

  int? getValue(TextEditingController ctrl) {
    return ctrl.text.isEmpty ? null : int.parse(ctrl.text);
  }

  List<Widget> getExceptionExerciseWidgets(List<PlanExceptionExerciseModel> exceptionExercises) {
    List<Widget> widgets = [];

    for (var element in exceptionExercises) {
      widgets.add(PlanExceptionExerciseItem(element: element));
    }

    return widgets;
  }

  // void initState() {
  //   scrollController.animateTo(offset, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wochen bearbeiten"),
          actions: <Widget>[
            BlocBuilder<PlanCreateBloc, PlanCreateState>(builder: (context, state) {
              PlanModel plan = state.plan!;

              return IconButton(
                icon: const Icon(Icons.save),
                tooltip: "Speichern",
                onPressed: () async {
                  Map<int, PlanWeekModel> planWeeks = {};

                  for (var i = 0; i < plan.cycles; i++) {
                    planWeeks[i] = PlanWeekModel(
                      name: nameControllers.elementAt(i).text,
                      isoWdh: getValue(isoWdhControllers.elementAt(i)),
                      isoSets: getValue(isoSetsControllers.elementAt(i)),
                      isoRpe: getValue(isoRpeControllers.elementAt(i)),
                      comWdh: getValue(comWdhControllers.elementAt(i)),
                      comSets: getValue(comSetsControllers.elementAt(i)),
                      comRpe: getValue(comRpeControllers.elementAt(i)),
                    );
                  }

                  sl<PlanCreateBloc>().add(UpdatePlanCreateEvent(planWeeks: planWeeks));
                  GoRouter.of(context).pop();
                },
              );
            })
          ],
        ),
        body: BlocBuilder<PlanCreateBloc, PlanCreateState>(builder: (context, state) {
          PlanModel plan = state.plan!;

          return Container(
            color: Theme.of(context).primaryColorDark,
            child: ListView.builder(
              controller: scrollController,
                itemCount: plan.cycles,
                itemBuilder: (context, index) {
                  nameControllers.add(TextEditingController());
                  isoWdhControllers.add(TextEditingController());
                  isoSetsControllers.add(TextEditingController());
                  isoRpeControllers.add(TextEditingController());
                  comWdhControllers.add(TextEditingController());
                  comSetsControllers.add(TextEditingController());
                  comRpeControllers.add(TextEditingController());

                  List<PlanExceptionExerciseModel> exceptionExercises = [];

                  if (plan.planWeeks.containsKey(index)) {
                    PlanWeekModel planWeek = plan.planWeeks[index]!;

                    exceptionExercises = planWeek.exceptionalExercises;
                    nameControllers.elementAt(index).text = planWeek.name;
                    isoWdhControllers.elementAt(index).text =
                        planWeek.isoWdh == null ? "" : planWeek.isoWdh.toString();
                    isoSetsControllers.elementAt(index).text =
                        planWeek.isoSets == null ? "" : planWeek.isoSets.toString();
                    isoRpeControllers.elementAt(index).text =
                        planWeek.isoRpe == null ? "" : planWeek.isoRpe.toString();
                    comWdhControllers.elementAt(index).text =
                        planWeek.comWdh == null ? "" : planWeek.comWdh.toString();
                    comSetsControllers.elementAt(index).text =
                        planWeek.comSets == null ? "" : planWeek.comSets.toString();
                    comRpeControllers.elementAt(index).text =
                        planWeek.comRpe == null ? "" : planWeek.comRpe.toString();
                  }

                  return Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15.0),
                          border:
                              Border.all(color: Theme.of(context).primaryColorDark, width: 2.0)),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            child: PlanWeekTextInput(
                                              hint: "Woche ${index + 1}",
                                              textInputType: TextInputType.text,
                                              controller: nameControllers[index],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context)
                                                  .push("/plan-exception-exercise/$index");
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.05,
                                              width: MediaQuery.of(context).size.width * 0.15,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(Radius.circular(20))),
                                              child: const Icon(FontAwesomeIcons.plus,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: const [
                                                  Text(
                                                    "Isolations",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Coms",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ]),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  child: PlanWeekTextInput(
                                                    hint: "wdh",
                                                    textInputType: TextInputType.number,
                                                    controller: isoWdhControllers[index],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.15,
                                                    child: PlanWeekTextInput(
                                                      hint: "wdh",
                                                      textInputType: TextInputType.number,
                                                      controller: comWdhControllers[index],
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  child: PlanWeekTextInput(
                                                    hint: "sets",
                                                    textInputType: TextInputType.number,
                                                    controller: isoSetsControllers[index],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.15,
                                                    child: PlanWeekTextInput(
                                                      hint: "sets",
                                                      textInputType: TextInputType.number,
                                                      controller: comSetsControllers[index],
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  child: PlanWeekTextInput(
                                                    hint: "rpe",
                                                    textInputType: TextInputType.number,
                                                    controller: isoRpeControllers[index],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.15,
                                                    child: PlanWeekTextInput(
                                                      hint: "rpe",
                                                      textInputType: TextInputType.number,
                                                      controller: comRpeControllers[index],
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          children: getExceptionExerciseWidgets(exceptionExercises)));
                }),
          );
        }));
  }
}
