import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';
import 'package:workout_watcher/core/presentation/widgets/section_header_container.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
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
  final PlanCreateBloc planCreateBloc = sl<PlanCreateBloc>();

  final TextEditingController dayNameCtrl = TextEditingController();


  @override
  void initState() {
    super.initState();
    dayNameCtrl.text = planCreateBloc.state.plan!.planDays.elementAt(widget.dayNumber).name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanCreateBloc, PlanCreateState>(
        bloc: planCreateBloc,
        listener: (context, state) {
          if (state.status.hasChangedDayName) {
            dayNameCtrl.text = state.plan!.planDays.elementAt(widget.dayNumber).name;

            // TODO nicht immer zum ende vom text gehen bei Änderung
            int offset = dayNameCtrl.text.length;
            dayNameCtrl.selection = TextSelection.collapsed(offset: offset);
          }
        },
        builder: (context, state) {
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
                        planCreateBloc.add(
                            ChangeDayNameEvent(index: widget.dayNumber, name: dayNameCtrl.text));
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
                    child: SingleChildScrollView(
                      child: BlocBuilder<PlanCreateBloc, PlanCreateState>(
                        bloc: planCreateBloc,
                        buildWhen: (pre, curr) {
                          return curr.status.hasUpdated;
                        },
                        builder: (context, state) {
                          PlanDayModel planDay = state.plan!.planDays.elementAt(widget.dayNumber);
                          List<Widget> exerciseItems = [];

                          for (var exerciseId in planDay.exercises) {
                            exerciseItems.add(PlanDayExerciseItem(exerciseId: exerciseId));
                          }

                          return Column(
                            children: exerciseItems,
                          );
                        }
                      ),
                    )),
              )
            ],
          );
        });
  }
}
