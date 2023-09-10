import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_glimpse/preview/bloc/preview_bloc.dart';

import 'model/app.dart';

class LoadedPreview extends StatefulWidget {
  final App? app;
  const LoadedPreview({
    super.key,
    required ScrollController scrollController,
    required this.app,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  State<LoadedPreview> createState() => _LoadedPreviewState();
}

class _LoadedPreviewState extends State<LoadedPreview> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _appSellerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _whatsNewController = TextEditingController();
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
                                context.read<PreviewBloc>().add(UpdateAppIcon(
                                    app: widget.app!, icon: image));
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
                              image: widget.app?.appIcon != null
                                  ? DecorationImage(
                                      image: NetworkImage(widget.app!.appIcon!),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: widget.app?.appIcon == null
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
                                    widget.app?.name != null
                                        ? Text(
                                            widget.app!.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w800),
                                          )
                                        : SizedBox(
                                            width: 300,
                                            child: CupertinoTextField(
                                              controller: _nameController,
                                              placeholder: 'App Name',
                                            )),
                                    const GutterTiny(),
                                  ],
                                ),
                                const GutterTiny(),
                                widget.app?.subtitle != null
                                    ? Text(
                                        widget.app!.subtitle!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : SizedBox(
                                        width: 300,
                                        child: CupertinoTextField(
                                          controller: _subtitleController,
                                          placeholder: 'Subtitle',
                                        )),
                                const GutterTiny(),
                                widget.app?.appSeller != null
                                    ? Text(
                                        widget.app!.appSeller!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : const SizedBox(
                                        width: 300, child: Text('')),
                                const GutterTiny(),
                                Text.rich(TextSpan(
                                    text: widget.app!.price! == 0.0
                                        ? 'Free'
                                        : '\$${widget.app!.price!}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text:
                                              widget.app?.inAppPurchases == true
                                                  ? ' · Offers In-App Purchases'
                                                  : ''),
                                    ]))
                              ],
                            ),
                            const GutterTiny(),
                            widget.app?.ageRating != null
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
                                      '${widget.app!.ageRating!}+',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                  )
                                : Container(
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
                                      '4+',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                  )
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
                    Text('iPhone Screenshots',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20))
                  ]),
                  const Gutter(),
                  // TODO: Fix this
                  widget.app?.screenshots == null ||
                          widget.app!.screenshots!.isNotEmpty
                      ? const SizedBox(
                          height: 60,
                          child: Text('No screenshots uploaded.'),
                        )
                      : SizedBox(
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
                              controller: widget._scrollController,
                              child: ListView.builder(
                                itemExtent: 172,
                                itemCount: widget.app?.screenshots?.length ?? 6,
                                padding: const EdgeInsets.only(bottom: 20.0),
                                controller: widget._scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (widget.app?.screenshots == null ||
                                      widget.app!.screenshots!.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: SizedBox(
                                          height: 370,
                                          width: 800,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.grey[200],
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              onTap: () async {
                                                await ImagePicker()
                                                    .pickMultiImage()
                                                    .then((images) {
                                                  if (images.isNotEmpty) {
                                                    context
                                                        .read<PreviewBloc>()
                                                        .add(AddScreenshots(
                                                            app: widget.app!,
                                                            screenshots:
                                                                images));
                                                  }
                                                  return images;
                                                });
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[300]!,
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                  child: const Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                            ),
                                          )),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.0),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/07/6c/c9/076cc99d-cae3-446e-58e3-36ece27c267f/f7f3bb21-8f3f-4a48-b1ba-45bdb95a6ddb_Frame_5.jpg/230x0w.webp'),
                                            fit: BoxFit.cover),
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  );
                                },
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
                  widget.app?.description != null
                      ? Text(
                          widget.app!.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.0),
                        )
                      : SizedBox(
                          width: 800,
                          child: CupertinoTextField(
                            controller: _descriptionController,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.app?.whatsNew != null
                              ? Flexible(
                                  child: Text(
                                    widget.app!.whatsNew!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 12.0),
                                  ),
                                )
                              : SizedBox(
                                  width: 600,
                                  child: CupertinoTextField(
                                    controller: _whatsNewController,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    placeholder: 'What\'s New',
                                    maxLines: 10,
                                  )),
                          widget.app?.version != null
                              ? Text(
                                  'Version 1.0.1',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 12),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                      width: 180,
                                      child: CupertinoTextField(
                                        controller: _versionController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        placeholder: 'Version',
                                      )),
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
                          widget.app?.appSeller != null
                              ? Flexible(
                                  child: Text(
                                    '''
The developer, ${widget.app!.appSeller!}, indicated that the app's privacy practices may include handling of data as described below. For more information, see the developer's privacy policy.''',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 12.0),
                                  ),
                                )
                              : Flexible(
                                  child: Text(
                                    '''
The developer, ???, indicated that the app's privacy practices may include handling of data as described below. For more information, see the developer's privacy policy.''',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 12.0),
                                  ),
                                )
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
                                  widget.app?.appSeller != null
                                      ? widget.app!.appSeller!
                                      : '???',
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
                                  widget.app?.appSize != null
                                      ? widget.app!.appSize!.toString()
                                      : '90.5 MB',
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
                                Text(
                                    widget.app?.category != null
                                        ? widget.app!.category!
                                        : '???',
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
                                Text(
                                    widget.app?.compatibility != null
                                        ? widget.app!.compatibility!
                                        : 'iPhone, iPad',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                widget.app?.minimumIOSVersion != null
                                    ? Text(
                                        'Requires ${widget.app!.minimumIOSVersion} or later.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 12.0),
                                      )
                                    : Text(
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
                                  widget.app?.languages != null
                                      ? widget.app!.languages!
                                      : 'English',
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
                                  widget.app?.ageRating != null
                                      ? widget.app!.ageRating!
                                      : '4+',
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
                                  widget.app?.copyright != null
                                      ? widget.app!.copyright!
                                      : '© ???',
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
                                  widget.app?.price != null
                                      ? widget.app!.price! == 0.0
                                          ? 'Free'
                                          : '\$${widget.app!.price!}'
                                      : 'Free',
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
