import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_glimpse/app/router/app_router.dart';
import 'package:store_glimpse/auth/bloc/auth_bloc.dart';
import 'package:store_glimpse/onboarding/bloc/onboarding_bloc.dart';
import 'package:store_glimpse/profile/model/user.dart';
import 'package:store_glimpse/signup/cubit/signup_cubit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: _pageController,
      children: [
        CreateAccountPage(
            pageController: _pageController,
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    ));
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    super.key,
    required PageController pageController,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _pageController = pageController,
        _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final PageController _pageController;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.success) {
          print('Success: ${context.read<AuthBloc>().state.user!.uid}');
          context.read<OnboardingBloc>().add(StartOnboarding(
                  user: User(
                id: context.read<AuthBloc>().state.user!.uid,
                email: _emailController.value.text,
              )));
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create an account',
                  style: Theme.of(context).textTheme.headlineMedium),
              const GutterSmall(),
              Text(
                  'Sign up to get started, you\'ll then be redirected to the checkout page!',
                  style: Theme.of(context).textTheme.bodyLarge),
              const Gutter(),
              SizedBox(
                width: 400,
                child: CupertinoFormSection.insetGrouped(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    children: [
                      CupertinoTextFormFieldRow(
                        controller: _emailController,
                        readOnly: state.status == SignupStatus.submitting,
                        placeholder: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (EmailValidator.validate(value) == false) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      CupertinoTextFormFieldRow(
                        controller: _passwordController,
                        readOnly: state.status == SignupStatus.submitting,
                        obscureText: true,
                        placeholder: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ]),
              ),
              const GutterSmall(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignupCubit>().signup(
                        email: _emailController.value.text,
                        password: _passwordController.value.text);
                  }
                },
                child: state.status == SignupStatus.submitting ||
                        context.watch<OnboardingBloc>().state
                            is OnboardingLoading
                    ? const CupertinoActivityIndicator()
                    : const Text('Submit'),
              ),
              const GutterTiny(),
              SizedBox(
                height: 46,
                child: FittedBox(
                  child: CupertinoButton(
                      minSize: 0,
                      child: const Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        await SharedPreferences.getInstance().then((value) {
                          value.setBool('completedOnboarding', true);
                          return value;
                        }).then((value) {
                          goRouter.go('/login');
                          return value;
                        });
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
