import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_state.dart';
import 'package:workout_watcher/features/plans/bloc/plan_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_event.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_day_container.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_day_page_indicator.dart';

class PlanPageDays extends StatefulWidget {
  final String planId;

  const PlanPageDays({Key? key, required this.planId}) : super(key: key);

  @override
  State<PlanPageDays> createState() => _PlanPageDaysState();
}

class _PlanPageDaysState extends State<PlanPageDays> {
  final TextEditingController dayCtrl = TextEditingController();
  PlanDayModel? currentPlanDay;
  int currentDayNumber = 0;

  void setCurrentDay(PlanDayModel planDay) {
    currentPlanDay = planDay;
    dayCtrl.text = planDay.name;
  }

  @override
  void initState() {
    super.initState();
    // sl<PlanCreateBloc>().add(SwitchDayEvent(selectedDay: 0));
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

    return Scaffold(
        appBar: AppBar(
            title: const Text("Tage"),
          actions: [
            IconButton(onPressed: () {
              PlanModel plan = sl<PlanCreateBloc>().state.plan!;
              sl<PlanBloc>().add(UpdatePlanEvent(plan));
              sl<PlanBloc>().add(GetAllPlansEvent());
              GoRouter.of(context).go("/plans");
            }, icon: const Icon(Icons.save))
          ],
        ),
        body: Container(
            color: Theme.of(context).primaryColorDark,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(2.0),
            child: BlocConsumer<PlanCreateBloc, PlanCreateState>(
              listener: (context, state) async {
                if (state.status.isInitial) {
                  List<PlanDayModel> planDays = state.plan!.planDays;

                  // initially set first day
                  setCurrentDay(planDays.elementAt(0));
                  sl<PlanCreateBloc>().add(SwitchDayEvent(selectedDay: 0));
                } else if (state.status.isSwitchDay) {
                  FocusScope.of(context).unfocus();
                  await pageController.animateToPage(state.dayIndex!,
                      duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  // await Future.delayed(Duration(seconds: 2));
                  sl<PlanCreateBloc>().add(SwitchedDayEvent());

                }
              },
              builder: (context, state) {
                List<PlanDayModel> planDays = state.plan!.planDays;
                List<Widget> dayRowItems = [];
                List<Widget> planDayInfoContainers = [];

                currentPlanDay = currentPlanDay ?? planDays.elementAt(0);

                for (int i = 0; i < planDays.length; i++) {
                  PlanDayModel planDay = planDays.elementAt(i);

                  dayRowItems.add(DayRowItem(name: planDay.name, dayNumber: i));
                  planDayInfoContainers.add(PlanDayContainer(planDay: planDay, dayNumber: i));
                }

                return Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: dayRowItems
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: planDayInfoContainers,
                      onPageChanged: (value) {
                        currentDayNumber = value;
                        if (state.isCurrentlySwitchingDay != true) {
                          sl<PlanCreateBloc>().add(SwitchDayEvent(selectedDay: value));
                        }
                      },
                    ),
                  ),
                ]);
              },
            )));
  }
}

class ExerciseAdditionalInfoContainer extends StatelessWidget {
  final String itemText;

  const ExerciseAdditionalInfoContainer({
    Key? key,
    required this.itemText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          itemText,
          style: const TextStyle(fontSize: 15),
        ));
  }
}
