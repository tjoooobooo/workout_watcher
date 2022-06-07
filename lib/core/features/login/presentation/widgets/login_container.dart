import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/Widgets/CustomFormField.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainer();
}

class _LoginContainer extends State<LoginContainer> {
  final formGlobalKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: const Text("LogIn",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 35)),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
              hint: "Email",
              errorMsg: "Bitte Email eingeben",
              controller: emailCtrl,
            prefixIcon: Icon(
              Icons.email,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          TextFormField(
            controller: passCtrl,
            autofocus: false,
            keyboardType: TextInputType.text,
            obscureText: hidePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Bitte Passwort eingeben";
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  )),
              labelText: "Passwort",
              labelStyle:
                  const TextStyle(fontSize: 20.0, color: Colors.white),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              suffixIcon: IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: ((context, state) {
              if (state.status == AuthStateStatus.loading) {
                return const LoadingWidget();
              } else if (state.status == AuthStateStatus.error) {
                return Column(
                  children: [
                    const Text(
                      "Error",
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(LogInEvent(
                              emailCtrl.text.trim(), passCtrl.text.trim()));
                        }
                      },
                      child: const Text(
                        "Einloggen",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        sl<AuthBloc>().add(RegistrationModeEvent());
                      },
                      child: const Text(
                        "Registrieren",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                );
              }

              return Column(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          sl<AuthBloc>().add(LogInEvent(
                              emailCtrl.text.trim(), passCtrl.text.trim()));
                        }
                      },
                      child: const Text(
                        "Einloggen",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        sl<AuthBloc>().add(RegistrationModeEvent());
                      },
                      child: const Text(
                        "Registrieren",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    text: "Passwort vergessen? ",
                    style: const TextStyle(fontSize: 16),
                    recognizer: TapGestureRecognizer()..onTap = () {})),
            width: MediaQuery.of(context).size.width * 0.75,
          ),
        ],
      ),
    );
  }
}
