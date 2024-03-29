import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';
import 'package:workout_watcher/core/presentation/widgets/section_header_container.dart';
import 'package:workout_watcher/core/util/proxy_decorater.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_state.dart';
import 'package:workout_watcher/features/plans/bloc/plan_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_event.dart';
import 'package:workout_watcher/features/plans/bloc/plan_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_day_exercise_item.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_day_info_container.dart';

class PlanDayContainer extends StatefulWidget {
  const PlanDayContainer({Key? key, required this.planDay, required this.dayNumber})
      : super(key: key);

  final PlanDayModel planDay;
  final int dayNumber;

  @override
  State<PlanDayContainer> createState() => _PlanDayContainerState();
}

class _PlanDayContainerState extends State<PlanDayContainer> {
  final TextEditingController dayNameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    dayNameCtrl.text = sl<PlanCreateBloc>().state.plan!.planDays.elementAt(widget.dayNumber).name;
  }

  void onReorder(int oldIndex, int newIndex) {
    sl<PlanCreateBloc>().add(ReorderExerciseEvent(oldIndex: oldIndex, newIndex: newIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanCreateBloc, PlanCreateState>(listener: (context, state) {
      if (state.status.hasChangedDayName) {
        dayNameCtrl.text = state.plan!.planDays.elementAt(widget.dayNumber).name;

        // TODO nicht immer zum ende vom text gehen bei Änderung
        int offset = dayNameCtrl.text.length;
        dayNameCtrl.selection = TextSelection.collapsed(offset: offset);
      }
    }, builder: (context, state) {
      return Column(
        children: [
          PlanDaySummaryContainer(planDay: widget.planDay, index: widget.dayNumber),
          Container(
              width: MediaQuery.of(context).size.width * 0.925,
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: IconLabelTextRow(
                iconData: Icons.abc_rounded,
                label: "Name",
                controller: dayNameCtrl,
                onChanged: (value) {
                  sl<PlanCreateBloc>()
                      .add(ChangeDayNameEvent(index: widget.dayNumber, name: dayNameCtrl.text));
                },
              )),
          SectionHeaderContainer(
            header: "Übungen",
            icon: GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/exercises?selectionMode=true");
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.925,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: BlocBuilder<PlanCreateBloc, PlanCreateState>(buildWhen: (pre, curr) {
                  return curr.status.hasUpdated;
                }, builder: (context, state) {
                  PlanDayModel planDay = state.plan!.planDays.elementAt(widget.dayNumber);
                  List<Widget> exerciseItems = [];

                  for (var exerciseId in planDay.exercises) {
                    exerciseItems.add(Container(key: Key(exerciseId), child: PlanDayExerciseItem(exerciseId: exerciseId)));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ReorderableListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          onReorder: onReorder,
                          proxyDecorator: proxyDecorator,
                          children: exerciseItems,
                        ),
                      ],
                    ),
                  );
                })),
          ),
          sl<PlanCreateBloc>().state.plan!.state != PlanModelStates.ready
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.925,
                  height: MediaQuery.of(context).size.height * 0.06,
                  margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      PlanModel plan = sl<PlanCreateBloc>().state.plan!;
                      PlanModel newPlan = plan.copyWith(state: PlanModelStates.ready);

                      sl<PlanBloc>().add(UpdatePlanEvent(newPlan));
                      sl<PlanBloc>().add(GetAllPlansEvent());
                      GoRouter.of(context).go("/plans");
                    },
                    child: const Text(
                      "Bearbeitung abschließen",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : Container()
        ],
      );
    });
  }
}
