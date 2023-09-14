import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_glimpse/profile/model/user.dart';
import 'package:store_glimpse/stripe/bloc/stripe_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'StoreGlimpse',
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: GoogleFonts.baloo2().fontFamily,
                        fontWeight: FontWeight.w800),
                  ),
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Home')),
                      const Gutter(),
                      TextButton(
                          onPressed: () {}, child: const Text('Pricing')),
                      const Gutter(),
                      TextButton(
                          onPressed: () {}, child: const Text('Contact')),
                      const Gutter(),
                      SizedBox(
                        height: 36,
                        child: FittedBox(
                          child: CupertinoButton.filled(
                              minSize: 0,
                              onPressed: () {},
                              child: const Text('Log In')),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 400,
                                child: Text(
                                  'Preview Your App,\nBefore Hitting Publish.',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                ),
                              ),
                              const GutterSmall(),
                              Text(
                                  'See how your app will look on the App Store.',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.black87)),
                              const Gutter(),
                              BlocBuilder<StripeBloc, StripeState>(
                                builder: (context, state) {
                                  if (state is StripeLoading) {
                                    return CupertinoButton.filled(
                                      minSize: 0,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CupertinoActivityIndicator(
                                            color: Colors.white,
                                          ),
                                          GutterSmall(),
                                          Text('Loading...'),
                                        ],
                                      ),
                                      onPressed: () {},
                                    );
                                  }
                                  return CupertinoButton.filled(
                                    minSize: 0,
                                    child: const Text('Get StoreGlimpse'),
                                    onPressed: () {
                                      context
                                          .read<StripeBloc>()
                                          .add(InitiatePurchase(User()));
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 700),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          constraints: const BoxConstraints(
                              maxHeight: 400, maxWidth: 400),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/build_screenshot.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 400,
                              child: Text(
                                'Why StoreGlimpse?',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const GutterSmall(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: BenefitListItem(
                            icon: Icons.search,
                            title: 'Optimize Your App Store Listing',
                            description:
                                'Nail your copy, screenshots, and app\npreview to maximize downloads.',
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: BenefitListItem(
                            mainAxisAlignment: MainAxisAlignment.start,
                            icon: Icons.check,
                            title: 'Get It Right the First Time.',
                            description:
                                'Make sure your app looks great before\nyou publish it to the App Store.',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: BenefitListItem(
                            icon: Icons.build_circle_outlined,
                            title: 'Build a Preview in Minutes.',
                            description:
                                'Input your app details & screenshots,\nthen instantly see how it’ll look!',
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: BenefitListItem(
                            icon: Icons.crop,
                            title: 'Perfect Screenshots Every Time.',
                            description:
                                'Correct sizing, spacing, & alignment\nfor all your screenshots.',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class BenefitListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final MainAxisAlignment? mainAxisAlignment;

  const BenefitListItem({
    required this.icon,
    required this.title,
    required this.description,
    this.mainAxisAlignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Icon(icon, size: 36, color: Colors.black87),
        const Gutter(),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const GutterSmall(),
                SizedBox(
                  width: 350,
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
