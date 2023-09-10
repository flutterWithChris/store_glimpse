import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_glimpse/preview/bloc/preview_bloc.dart';
import 'package:store_glimpse/preview/editable_preview.dart';
import 'package:store_glimpse/preview/loaded_preview.dart';
import 'package:store_glimpse/preview/model/app.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final ScrollController _scrollController = ScrollController();
  String? _ageRating;
  bool? _isFree;
  bool? _hasInAppPurchases;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey[100],
              child: UnconstrainedBox(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 960),
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      const Expanded(
                        child: Icon(
                          Icons.apple,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Store',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Mac',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'iPad',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'iPhone',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Watch',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'AirPods',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'TV & Home',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Entertainment',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Accessories',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Support',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 16,
                                style: IconButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    fixedSize: const Size(20, 20),
                                    minimumSize: const Size(20, 20)),
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.search,
                                  color: Colors.black87,
                                  size: 16,
                                )),
                            IconButton(
                                iconSize: 16,
                                style: IconButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    fixedSize: const Size(20, 20),
                                    minimumSize: const Size(20, 20)),
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.bag,
                                  color: Colors.black87,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
                child: Text(
                  'App Store',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
            ],
          )),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
            sliver: BlocBuilder<PreviewBloc, PreviewState>(
              builder: (context, state) {
                if (state is PreviewError) {
                  return const SliverFillRemaining(
                      child: Center(child: Text('Error loading preview...')));
                }
                if (state is PreviewLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                        child: Row(
                      children: [
                        CircularProgressIndicator(),
                        Gutter(),
                        Text('Building Preview...'),
                      ],
                    )),
                  );
                }
                if (state is PreviewInitial || state is EditingPreview) {
                  return EditablePreview(
                    scrollController: _scrollController,
                    app: state.app,
                  );
                }
                if (state is PreviewLoaded || state is PreviewInitial) {
                  return LoadedPreview(
                      scrollController: _scrollController, app: state.app);
                } else {
                  return const Center(child: Text('Something Went Wrong...'));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
void _showDialog(Widget child, BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      // The Bottom margin is provided to align the popup above the system navigation bar.
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // Provide a background color for the popup.
      color: CupertinoColors.systemBackground.resolveFrom(context),
      // Use a SafeArea widget to avoid system overlaps.
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}

class AgeRatingPicker extends StatefulWidget {
  const AgeRatingPicker({
    super.key,
  });

  @override
  State<AgeRatingPicker> createState() => _AgeRatingPickerState();
}

class _AgeRatingPickerState extends State<AgeRatingPicker> {
  List<String> ageRatings = ['4+', '9+', '12+', '17+'];
  int selectedAgeRating = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Age Rating',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const GutterTiny(),
        CupertinoSlidingSegmentedControl(
          groupValue: selectedAgeRating,
          children: const {
            0: Text(
              '4+',
              style: TextStyle(fontSize: 12),
            ),
            1: Text(
              '9+',
              style: TextStyle(fontSize: 12),
            ),
            2: Text(
              '12+',
              style: TextStyle(fontSize: 12),
            ),
            3: Text(
              '17+',
              style: TextStyle(fontSize: 12),
            ),
          },
          onValueChanged: (value) {
            setState(() {
              selectedAgeRating = value as int;
            });
            // App app = context.read<PreviewBloc>().state.app!;
            // context.read<PreviewBloc>().add(UpdatePreview(
            //     app: app.copyWith(ageRating: ageRatings[value as int])));
          },
        ),
      ],
    );
  }
}

class PriceSwitches extends StatefulWidget {
  final App? app;
  final TextEditingController priceController;
  bool isFree;
  bool hasInAppPurchases;
  PriceSwitches({
    this.app,
    required this.priceController,
    required this.isFree,
    required this.hasInAppPurchases,
    super.key,
  });

  @override
  State<PriceSwitches> createState() => _PriceSwitchesState();
}

class _PriceSwitchesState extends State<PriceSwitches> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Free'),
            const GutterTiny(),
            CupertinoSwitch(
                value: widget.isFree ?? widget.app?.price == 0.00,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      widget.priceController.text = '0.00';
                    } else {
                      widget.priceController.text = '';
                    }
                    widget.isFree = value;
                  });
                })
          ],
        ),
        const Gutter(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('In-App Purchases'),
            const GutterTiny(),
            CupertinoSwitch(
                value: widget.hasInAppPurchases,
                onChanged: (value) {
                  setState(() {
                    widget.hasInAppPurchases = value;
                  });
                })
          ],
        )
      ],
    );
  }
}
