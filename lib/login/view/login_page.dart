import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:go_router/go_router.dart';
import 'package:store_glimpse/login/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   const Gutter(),
              SizedBox(
                width: 420,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: CupertinoButton(
                        minSize: 0,
                        child: const Text('New? Sign Up.'),
                        onPressed: () => Navigator.pushNamed(context, '/'),
                      ),
                    ),
                  ],
                ),
              ),
              const GutterTiny(),
              SizedBox(
                width: 400,
                child: CupertinoTextField(
                  placeholder: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => print(value),
                ),
              ),
              const GutterSmall(),
              SizedBox(
                width: 400,
                child: CupertinoTextField(
                  placeholder: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (value) => print(value),
                ),
              ),
              const Gutter(),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is LoginSuccess) {
                    context.go('/');
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    height: 36,
                    child: FittedBox(
                      child: CupertinoButton.filled(
                        minSize: 0,
                        child: state is LoginLoading
                            ? const CupertinoActivityIndicator()
                            : const Text('Login'),
                        onPressed: () => state is LoginLoading ||
                                state is LoginSuccess
                            ? null
                            : context
                                .read<LoginCubit>()
                                .loginWithEmailAndPassword(
                                    email: _emailController.value.text,
                                    password: _passwordController.value.text),
                      ),
                    ),
                  );
                },
              ),
              const GutterTiny(),
              CupertinoButton(
                minSize: 0,
                child: const Text('Forgot Password?'),
                onPressed: () => Navigator.pushNamed(context, '/'),
              ),
            ],
          )),
        ],
      )),
    );
  }
}
