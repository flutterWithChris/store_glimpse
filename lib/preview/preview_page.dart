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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
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
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Center(child: Text('4+')),
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
            ),
            const GutterSmall(),
            const Divider(
              indent: 120,
              endIndent: 120,
            ),
            const GutterSmall(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120.0),
                  child: Row(
                    children: [
                      Text('iPhone Screenshots',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
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
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1.0),
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
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1.0),
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
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1.0),
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
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1.0),
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
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1.0),
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
            const Divider(
              indent: 120,
              endIndent: 120,
            ),
            const GutterSmall(),
            const Padding(
              padding: EdgeInsets.only(left: 60.0, right: 300),
              child: Column(
                children: [
                  Text('''
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
              ''')
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
