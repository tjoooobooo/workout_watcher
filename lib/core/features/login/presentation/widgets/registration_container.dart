import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/Widgets/CustomFormField.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/utils/AuthenticationService.dart';

class RegistrationContainer extends StatefulWidget {

  const RegistrationContainer({Key? key}) : super(key: key);

  @override
  State<RegistrationContainer> createState() => _RegistrationContainerState();
}

class _RegistrationContainerState extends State<RegistrationContainer> {
  final formGlobalKey = GlobalKey <FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: const Text("Registrieren",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 35)),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: nameCtrl,
              hint: "Name",
              errorMsg: "Bitte Name eingeben",
            ),
            CustomTextFormField(
              controller: emailCtrl,
              hint: "Email",
              errorMsg: "Bitte Email eingeben",
            ),
            CustomTextFormField(
                hint: "Passwort",
                errorMsg: "Bitte Passwort eingeben",
                controller: passCtrl
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      context.read<AuthenticationService>().signUp(
                          email: emailCtrl.text.trim(),
                          password: passCtrl.text.trim()
                      ).then((value) => {
                        context.read<AuthenticationService>().userSetup(
                        name: nameCtrl.text.trim()
                        )
                      });
                    }
                  },
                  child: const Text(
                      "Passwort wählen",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            RichText(
                text: TextSpan(
                    text: "Schon ein Konto? ",
                    style: const TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                          text: "LogIn",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              sl<AuthBloc>().add(LoginModeEvent());
                            })
                    ])),
          ],
        ),
      ),
    );
  }
}