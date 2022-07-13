import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/features/charts/presentation/pages/chart_page.dart';
import 'package:workout_watcher/ViewsList/MeasurementsListView.dart';
import 'package:workout_watcher/utils/Utils.dart';

class DefaultNavigationDrawer extends StatelessWidget {
  const DefaultNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: const Center(
                  child: Text(
                    'Workout-Tracker',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Theme.of(context).colorScheme.primary, Colors.black])),
              ),
              ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                  onTap: () {
                    // close the drawer
                    Navigator.pop(context);

                    GoRouter.of(context).go("/dashboard");
                  }),
              ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  title: const Text(
                      "Kalender",
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                  onTap: () {
                    Utils.showToast("Kalender noch nicht verfügbar");
                  }),
              ListTile(
                leading: const Icon(
                  Icons.auto_graph,
                  color: Colors.white,
                ),
                title: const Text(
                  "Übersichten",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChartPage()
                      )
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.rule_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  "Messungen",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);

                  GoRouter.of(context).go("/measurements");
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt,
                  color: Colors.white,
                ),
                title: const Text(
                  "Ziele",
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Utils.showToast("Ziele noch nicht verfügbar");
                },
              ),
              ListTile(
                  leading: const Icon(
                    Icons.assignment,
                    color: Colors.white,
                  ),
                  title: const Text(
                      "Plan",
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                  onTap: () {
                    // close the drawer
                    Navigator.pop(context);

                    GoRouter.of(context).go("/plans");
                  }
                  ),
              ListTile(
                leading: const Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
                title: const Text(
                  "Übungen",
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go("/exercises");
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: const Text(
                  "Einstellungen",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                 GoRouter.of(context).go("/settings");
                },
              ),
            ],
          ),
        )
    );
  }
}
