import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StripeCancelledPage extends StatelessWidget {
  const StripeCancelledPage({super.key});

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
                'Checkout Cancelled',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Your payment was cancelled. Please try again.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 40,
            child: FittedBox(
              child: CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context).pushNamed('/welcome');
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
