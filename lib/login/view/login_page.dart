import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              Text(
                'Login to Store Glimpse',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gutter(),
              SizedBox(
                width: 400,
                child: CupertinoTextField(
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => print(value),
                ),
              ),
              const GutterSmall(),
              SizedBox(
                width: 400,
                child: CupertinoTextField(
                  placeholder: 'Password',
                  obscureText: true,
                  onChanged: (value) => print(value),
                ),
              ),
              const Gutter(),
              SizedBox(
                height: 36,
                child: FittedBox(
                  child: CupertinoButton.filled(
                    minSize: 0,
                    child: const Text('Login'),
                    onPressed: () => Navigator.pushNamed(context, '/'),
                  ),
                ),
              ),
              const GutterSmall(),
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
