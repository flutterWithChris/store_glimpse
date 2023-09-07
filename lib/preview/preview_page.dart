import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(
                Icons.apple,
                size: 20,
              ),
            ),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 70.0, top: 12.0),
              child: Wrap(
                spacing: 40.0,
                children: [
                  Text(
                    'Store',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Mac',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'iPad',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'iPhone',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Watch',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'AirPods',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'TV & Home',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Entertainment',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Accesories',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Support',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                      style: IconButton.styleFrom(
                          fixedSize: const Size(20, 20),
                          minimumSize: const Size(20, 20)),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.search,
                        size: 16,
                      )),
                  IconButton(
                      style: IconButton.styleFrom(
                          fixedSize: const Size(20, 20),
                          minimumSize: const Size(20, 20)),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.bag,
                        size: 16,
                      ))
                ],
              ),
            ),
            expandedHeight: 40,
            toolbarHeight: 40,
            collapsedHeight: 40,
            floating: true,
            backgroundColor: Colors.grey[100],
            snap: true,
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
              const Divider(),
            ],
          )),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 120.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/77/f6/57/77f65719-ae2c-4a0d-65f6-15fe2ed638d1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/230x0w.webp'),
                          fit: BoxFit.cover),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  const Gutter(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Find & Save Places | GottaGo',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const GutterTiny(),
                            Container(
                              width: 25,
                              height: 16,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(
                                  child: Text(
                                '4+',
                                style: Theme.of(context).textTheme.bodySmall,
                              )),
                            )
                          ],
                        ),
                        Text(
                          'Date ideas, travel plans, etc.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Christian Vergara',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const GutterSmall(),
                        Text('Free · Offers In-App Purchases',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )
                ],
              ),
              const GutterSmall(),
              const Divider(),
              const GutterSmall(),
              Column(
                children: [
                  Row(
                    children: [
                      Text('iPhone Screenshots',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                  const GutterSmall(),
                  SizedBox(
                    height: 350,
                    width: 720,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 160,
                          height: 200,
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
                        const Gutter(),
                        Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!, width: 1.0),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/c7/f9/3c/c7f93c2b-2cb6-deba-06e0-215b8e9b7120/ac09d2ce-e354-4853-b08b-d66980ede047_Frame_8.jpg/230x0w.webp'),
                                fit: BoxFit.cover),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        const Gutter(),
                        Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!, width: 1.0),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/d0/c6/84/d0c68498-3c6f-9eea-2afd-61983f226bcd/dfdf8c28-c73c-43b4-babe-a400138a14c7_Frame_24.jpg/230x0w.webp'),
                                fit: BoxFit.cover),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        const Gutter(),
                        Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!, width: 1.0),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/e9/2c/11/e92c11b5-330d-91ea-2302-094b3569c2ef/aea6592a-d120-444a-a2a3-74b75050eeea_Frame_6.jpg/230x0w.webp'),
                                fit: BoxFit.cover),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        const Gutter(),
                        Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!, width: 1.0),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/db/54/dd/db54ddb3-8353-e828-88f8-126ddcfefc75/4135bb2d-b205-43da-b114-07bd4005741c_Frame_9.jpg/230x0w.webp'),
                                fit: BoxFit.cover),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Gutter(),
              const Divider(),
              const GutterSmall(),
              Column(
                children: [
                  Text(
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
                        .bodySmall
                        ?.copyWith(fontSize: 12),
                  )
                ],
              ),
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
                            style: Theme.of(context).textTheme.bodySmall,
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
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      const GutterSmall(),
                      Row(
                        children: [
                          SizedBox(
                            height: 242,
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
                                      const Gutter(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 8.0,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.info_circle_fill,
                                                size: 18,
                                              ),
                                              Text(
                                                'Contact Info',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 8.0,
                                            children: [
                                              const Icon(
                                                CupertinoIcons
                                                    .photo_fill_on_rectangle_fill,
                                                size: 18,
                                              ),
                                              Text(
                                                'User Content',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const GutterSmall(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 8.0,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.doc,
                                                size: 18,
                                              ),
                                              Text(
                                                'Identifiers',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 8.0,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.gear_solid,
                                                size: 18,
                                              ),
                                              Text(
                                                'Diagnostics',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
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
                                  .bodySmall
                                  ?.copyWith(fontSize: 12)),
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
                                Text('Christian Vergara',
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
                                Text('Size',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('90.5 MB',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
                                Text('English',
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
                                Text('Age Rating',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('4+',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
                                Text('© Christian Vergara',
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
                                Text('Price',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('Free',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
                                Text('In-App Purchases',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('1. Premium Individual',
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
                                Text('\$4.99',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ])),
          )
        ],
      ),
    );
  }
}
