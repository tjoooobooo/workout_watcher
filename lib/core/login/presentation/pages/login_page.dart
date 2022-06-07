import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/core/login/bloc/bloc.dart';
import 'package:workout_watcher/core/login/presentation/widgets/login_container.dart';
import 'package:workout_watcher/core/login/presentation/widgets/registration_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formGlobalKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
        initialPage:
            getCurrentLoginPage(context.read<AuthBloc>().state.status));

    return Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500.withOpacity(0.8),
                            spreadRadius: 6,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            pageController.animateToPage(
                                getCurrentLoginPage(state.status),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: PageView(
                            controller: pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: const [
                              LoginContainer(),
                              RegistrationContainer()
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            )));
  }

  int getCurrentLoginPage(AuthStateStatus status) {
    switch (status) {
      case AuthStateStatus.login:
        return 0;
      case AuthStateStatus.registration:
        return 1;
      default:
        return 0;
    }
  }
}
