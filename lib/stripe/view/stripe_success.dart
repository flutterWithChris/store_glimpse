import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_glimpse/app/router/app_router.dart';

class StripeSuccessPage extends StatelessWidget {
  const StripeSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Success!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank you! Your payment was successful.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: FittedBox(
              child: CupertinoButton.filled(
                minSize: 0,
                onPressed: () {
                  SharedPreferences.getInstance().then((prefs) async {
                    await prefs
                        .setBool('completedOnboarding', true)
                        .then((value) {
                      goRouter.go('/welcome');
                    });
                  });
                },
                child: const Text('Continue'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
