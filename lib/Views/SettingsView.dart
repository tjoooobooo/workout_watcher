import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var isCreatin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Einstellungen"),
        ),
        drawer: DefaultNavigationDrawer(),
        body: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.black,
            child: Center(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.75,
                child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            sl<AuthBloc>().add(LogOutEvent());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  "Ausloggen",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  )
                              ),
                              Icon(Icons.logout),
                            ],
                          )
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                              "Kreatin Erinnerung",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              )
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Switch(
                              value: isCreatin,
                              onChanged: (value) {
                                setState(() {
                                  isCreatin = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                              inactiveTrackColor: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ]
                ),
              ),
            )
        )
    );
  }
}
