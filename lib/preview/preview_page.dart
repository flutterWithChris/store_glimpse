import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_glimpse/preview/bloc/preview_bloc.dart';
import 'package:store_glimpse/preview/model/app.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final ScrollController _scrollController = ScrollController();
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

class LoadedPreview extends StatelessWidget {
  final App? app;
  const LoadedPreview({
    super.key,
    required ScrollController scrollController,
    required this.app,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(
      [
        UnconstrainedBox(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(children: [
              UnconstrainedBox(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () async {
                            await ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then((image) {
                              if (image != null) {
                                context
                                    .read<PreviewBloc>()
                                    .add(UpdateAppIcon(app: app!, icon: image));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('No image selected.')));
                              }
                              return image;
                            });
                          },
                          child: Container(
                            width: 216,
                            height: 216,
                            decoration: BoxDecoration(
                              image: app?.appIcon != null
                                  ? DecorationImage(
                                      image: NetworkImage(app!.appIcon!),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: app?.appIcon == null
                                ? const Icon(
                                    CupertinoIcons.question_circle_fill,
                                    color: Colors.grey,
                                    size: 50,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const Gutter(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    app?.title != null
                                        ? Text(
                                            app!.title!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w800),
                                          )
                                        : const SizedBox(
                                            width: 300,
                                            child: CupertinoTextField(
                                              placeholder: 'App Name',
                                            )),
                                    const GutterTiny(),
                                  ],
                                ),
                                const GutterSmall(),
                                app?.subtitle != null
                                    ? Text(
                                        'Date ideas, travel plans, etc.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : const SizedBox(
                                        width: 300,
                                        child: CupertinoTextField(
                                          placeholder: 'Subtitle',
                                        )),
                                const GutterSmall(),
                                app?.appSeller != null
                                    ? Text(
                                        'Christian Vergara',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : const SizedBox(
                                        width: 300,
                                        child: CupertinoTextField(
                                          placeholder: 'App Seller',
                                        )),
                                const GutterSmall(),
                                app?.price != null &&
                                        app?.inAppPurchases != null
                                    ? Text.rich(TextSpan(
                                        text: app!.price! == 0.0
                                            ? 'Free'
                                            : '\$${app!.price!}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                        children: const [
                                            TextSpan(
                                                text:
                                                    ' · Offers In-App Purchases'),
                                          ]))
                                    : const Row(
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: CupertinoTextField(
                                                placeholder: 'Price',
                                              )),
                                          Gutter(),
                                        ],
                                      ),
                              ],
                            ),
                            app?.ageRating != null
                                ? Container(
                                    width: 25,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Center(
                                        child: Text(
                                      '${app!.ageRating!}+',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: AgeRatingPicker(),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Gutter(),
              const Divider(
                thickness: 1.0,
              ),
              const GutterSmall(),
              Column(
                children: [
                  Row(children: [
                    app?.screenshots != null && app!.screenshots!.isNotEmpty
                        ? Text('iPhone Screenshots',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20))
                        : Row(
                            children: [
                              Text('iPhone Screenshots',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                              const GutterTiny(),
                              CupertinoButton(
                                  onPressed: () async {
                                    List<XFile>? images = await ImagePicker()
                                        .pickMultiImage()
                                        .then(
                                      (images) {
                                        if (images.isNotEmpty) {
                                          context.read<PreviewBloc>().add(
                                              AddScreenshots(
                                                  app: app!,
                                                  screenshots: images));
                                        }
                                        return images;
                                      },
                                    );
                                  },
                                  child: const Text('Add Screenshots'))
                            ],
                          )
                  ]),
                  const Gutter(),
                  // TODO: Fix this
                  SizedBox(
                    height: 370,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        scrollbarTheme: ScrollbarThemeData(
                          thumbColor:
                              MaterialStateProperty.all(Colors.grey[400]),
                          trackColor:
                              MaterialStateProperty.all(Colors.grey[200]),
                          radius: const Radius.circular(0.0),
                          thickness: MaterialStateProperty.all(16.0),
                        ),
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: _scrollController,
                        child: ListView.builder(
                          itemExtent: 172,
                          itemCount: app?.screenshots?.length ?? 6,
                          padding: const EdgeInsets.only(bottom: 20.0),
                          controller: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (app?.screenshots == null ||
                                app!.screenshots!.isEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                    height: 370,
                                    width: 800,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Colors.grey[200],
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .question_circle_fill,
                                                  color: Colors.grey,
                                                  size: 50,
                                                ),
                                              ],
                                            ),
                                          )),
                                    )),
                              );
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[300]!, width: 1.0),
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                                      fit: BoxFit.cover),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            );
                          },
                          // children: [
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/c7/f9/3c/c7f93c2b-2cb6-deba-06e0-215b8e9b7120/ac09d2ce-e354-4853-b08b-d66980ede047_Frame_8.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/d0/c6/84/d0c68498-3c6f-9eea-2afd-61983f226bcd/dfdf8c28-c73c-43b4-babe-a400138a14c7_Frame_24.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/e9/2c/11/e92c11b5-330d-91ea-2302-094b3569c2ef/aea6592a-d120-444a-a2a3-74b75050eeea_Frame_6.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/db/54/dd/db54ddb3-8353-e828-88f8-126ddcfefc75/4135bb2d-b205-43da-b114-07bd4005741c_Frame_9.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/db/54/dd/db54ddb3-8353-e828-88f8-126ddcfefc75/4135bb2d-b205-43da-b114-07bd4005741c_Frame_9.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //           color: Colors.grey[300]!,
                          //           width: 1.0),
                          //       image: const DecorationImage(
                          //           image: NetworkImage(
                          //               'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/db/54/dd/db54ddb3-8353-e828-88f8-126ddcfefc75/4135bb2d-b205-43da-b114-07bd4005741c_Frame_9.jpg/230x0w.webp'),
                          //           fit: BoxFit.cover),
                          //       color: Colors.grey,
                          //       borderRadius:
                          //           BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          // ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Gutter(),
              const Divider(
                thickness: 1.0,
              ),
              const GutterSmall(),
              Column(
                children: [
                  app?.description != null
                      ? Text(
                          '''
New 'Explore' page built with AI recommends places for you to visit!
                        
                        
Save & explore places you want to visit, share them with friends, & let fate choose your plans.
                        
                        
Always have an answer when someone says, "Where should we go?". Gottago makes it easy to save restaurants, points of interest, travel stops, or really any kind of place!
                        
                        
While enabling you to save them into beautiful, neatly categorized lists with useful info like website, phone number, & directions at your fingertips.
                        
                        
Features:
                        
- Create lists for different categories.
- AI-Powered explore page to find new places to visit!
- Search & add places from Google
- Invite friends to collaborate on lists.
- Quick access to hours, website, address, & phone number.
- Use the random wheel to make choosing plans easy! 
- Mark places visited & keep track of them!
                    
                        
Terms of Use: https://www.apple.com/legal/internet-services/itunes/dev/stdeula/
                        
                        
Privacy Policy: https://www.termsfeed.com/live/80c41a79-6cf2-404c-9daa-b469b07a7c58
                        ''',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        )
                      : const SizedBox(
                          width: 800,
                          child: CupertinoTextField(
                            textCapitalization: TextCapitalization.sentences,
                            placeholder: 'Description',
                            maxLines: 10,
                          )),
                ],
              ),
              const GutterSmall(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  const GutterTiny(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("What's New",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Version History'))
                    ],
                  ),
                  const GutterSmall(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '''
- Fixed issue that caused crashed on Apple Sign-In when name wasn't provided.
 - Updated the place details view to be a page instead of a sheet. With a sweeet transition.''',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 12.0),
                          ),
                          Text(
                            'Version 1.0.1',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      const GutterSmall(),
                    ],
                  ),
                ],
              ),
              const Divider(),
              const GutterSmall(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("App Privacy",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                      TextButton(
                          onPressed: () {}, child: const Text('See Details'))
                    ],
                  ),
                  const GutterSmall(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '''
The developer, Christian Vergara, indicated that the app's privacy practices may include handling of data as described below. For more information, see the developer's privacy policy.''',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                      const GutterSmall(),
                      Row(
                        children: [
                          SizedBox(
                            height: 230,
                            width: 350,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              elevation: 0,
                              color: Colors.grey[100],
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.person_circle,
                                          color: Colors.blue[800], size: 34),
                                      const GutterTiny(),
                                      Text(
                                        'Data Linked to You',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const GutterTiny(),
                                      Text(
                                        'The following data may be collected and linked to your identity:',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                      const GutterSmall(),
                                      const GutterTiny(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      spacing: 8.0,
                                                      children: [
                                                        const Icon(
                                                          CupertinoIcons
                                                              .info_circle_fill,
                                                          color: Colors.black87,
                                                          size: 18,
                                                        ),
                                                        Text(
                                                          'Contact Info',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          12),
                                                        )
                                                      ],
                                                    ),
                                                    const GutterSmall(),
                                                    Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      spacing: 8.0,
                                                      children: [
                                                        const Icon(
                                                          CupertinoIcons.doc,
                                                          color: Colors.black87,
                                                          size: 18,
                                                        ),
                                                        Text(
                                                          'Identifiers',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      spacing: 8.0,
                                                      children: [
                                                        const Icon(
                                                          CupertinoIcons
                                                              .photo_fill_on_rectangle_fill,
                                                          color: Colors.black87,
                                                          size: 18,
                                                        ),
                                                        Text(
                                                          'User Content',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          12),
                                                        ),
                                                      ],
                                                    ),
                                                    const GutterSmall(),
                                                    Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      spacing: 8.0,
                                                      children: [
                                                        const Icon(
                                                          CupertinoIcons
                                                              .gear_solid,
                                                          color: Colors.black87,
                                                          size: 18,
                                                        ),
                                                        Text(
                                                          'Diagnostics',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const GutterSmall(),
                      Row(
                        children: [
                          Text(
                            'Privacy practices may vary, for example, based on the features you use or your age.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 12.0),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text('Learn More'))
                        ],
                      ),
                      const GutterSmall(),
                      const Divider(),
                      const Gutter(),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Information',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                      const GutterSmall(),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Seller',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  'Christian Vergara',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Size',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  '90.5 MB',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gutter(),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Category',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('Travel',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Compatibiiity',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('iPhone',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                Text(
                                  'Requires iOS 12.0 or later.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gutter(),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Languages',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  'English',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Age Rating',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  '4+',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gutter(),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Copyright',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  '© Christian Vergara',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Price',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                  'Free',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gutter(),
                      Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('In-App Purchases',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text(
                                        '1. Premium Individual',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '\$4.99',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Gutter(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('App Support', style: TextStyle(fontSize: 12)),
                          GutterTiny(),
                          Icon(CupertinoIcons.arrow_up_right, size: 16),
                        ],
                      )),
                  const Gutter(),
                  TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('Privacy Policy',
                              style: TextStyle(fontSize: 12)),
                          GutterTiny(),
                          Icon(CupertinoIcons.arrow_up_right, size: 16),
                        ],
                      )),
                ],
              ),
              const Gutter(),
              const Divider(),
              const GutterTiny(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('You Might Also Like',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const Gutter(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.0),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                                  fit: BoxFit.cover),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          const GutterSmall(),
                          Text('Example App',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Gutter(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.0),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                                  fit: BoxFit.cover),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          const GutterSmall(),
                          Text('Example App',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Gutter(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.0),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                                  fit: BoxFit.cover),
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          const GutterSmall(),
                          Text('Example App',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Gutter(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.0),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                                  fit: BoxFit.cover),
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          const GutterSmall(),
                          Text('Example App',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ]),
          ),
        ),
      ],
    ));
  }
}

class AgeRatingPicker extends StatelessWidget {
  const AgeRatingPicker({
    super.key,
  });

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
          groupValue: 0,
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
          onValueChanged: (value) {},
        ),
        const Gutter(),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Free'),
                const GutterTiny(),
                CupertinoSwitch(value: true, onChanged: (value) {})
              ],
            ),
            const Gutter(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('In-App Purchases'),
                const GutterTiny(),
                CupertinoSwitch(value: true, onChanged: (value) {})
              ],
            )
          ],
        )
      ],
    );
  }
}
