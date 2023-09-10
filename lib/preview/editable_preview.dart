import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_glimpse/preview/bloc/preview_bloc.dart';
import 'package:store_glimpse/preview/preview_page.dart';

import 'model/app.dart';

class EditablePreview extends StatefulWidget {
  final App? app;
  const EditablePreview({
    super.key,
    required ScrollController scrollController,
    required this.app,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  State<EditablePreview> createState() => _EditablePreviewState();
}

class _EditablePreviewState extends State<EditablePreview> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _appSellerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _whatsNewController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _inAppPurchasesController =
      TextEditingController();
  final TextEditingController _copyRightController = TextEditingController();
  final bool _isFree = true;
  final bool _hasInAppPurchases = false;
  String? _ageRating;
  int? _ageRatingIndex;
  XFile? _appIcon;
  List<String> compatibility = [];
  List<XFile> _screenshots = [];
  final bool _availableOniPhone = true;
  final bool _availableOniPad = true;
  String _minimumIOSVersion = 'iOS 12';
  int _minimumIOSVersionIndex = 0;
  final List<String> _minimumIOSVersions = ['iOS 12', 'iOS 13', 'iOS 14'];

  @override
  void initState() {
    // TODO: implement initState
    if (_isFree == true) {
      _priceController.text = '0.00';
    }
    super.initState();
  }

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
                                setState(() {
                                  _appIcon = image;
                                  print('App Icon: $_appIcon');
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('No image selected.')));
                              }
                              return image;
                            });
                          },
                          child: FutureBuilder(
                              future: _appIcon?.readAsBytes(),
                              builder: (context, snapshot) {
                                var data = snapshot.data;
                                return Container(
                                  width: 216,
                                  height: 216,
                                  decoration: BoxDecoration(
                                    image: data != null
                                        ? // show image from bytes
                                        DecorationImage(
                                            image: MemoryImage(data),
                                            fit: BoxFit.cover)
                                        : widget.app?.appIcon != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    widget.app!.appIcon!),
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
                                );
                              }),
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
                                const GutterSmall(),
                                widget.app?.subtitle != null
                                    ? Text(
                                        'Date ideas, travel plans, etc.',
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
                                const GutterSmall(),
                                widget.app?.appSeller != null
                                    ? Text(
                                        'Christian Vergara',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : SizedBox(
                                        width: 300,
                                        child: CupertinoTextField(
                                          controller: _appSellerController,
                                          placeholder: 'App Seller',
                                        )),
                                const GutterSmall(),
                                widget.app?.price != null &&
                                        widget.app?.inAppPurchases != null
                                    ? Text.rich(TextSpan(
                                        text: widget.app!.price! == 0.0
                                            ? 'Free'
                                            : '\$${widget.app!.price!}',
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
                                    : Row(
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: CupertinoTextField(
                                                controller: _priceController,
                                                placeholder: 'Price',
                                                prefixMode:
                                                    OverlayVisibilityMode
                                                        .editing,
                                              )),
                                          const Gutter(),
                                        ],
                                      ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 32,
                                    child: FittedBox(
                                      child: CupertinoButton.filled(
                                          minSize: 0,
                                          onPressed: () {
                                            if (widget.app != null) {
                                              context
                                                  .read<PreviewBloc>()
                                                  .add(UpdatePreview(
                                                      app: widget.app!.copyWith(
                                                    name: _nameController.text,
                                                    subtitle:
                                                        _subtitleController
                                                            .text,
                                                    appSeller:
                                                        _appSellerController
                                                            .text,
                                                    price: double.tryParse(
                                                        _priceController.text),
                                                    version:
                                                        _versionController.text,
                                                    description:
                                                        _descriptionController
                                                            .text,
                                                    whatsNew:
                                                        _whatsNewController
                                                            .text,
                                                    category:
                                                        _categoryController
                                                            .text,
                                                    languages:
                                                        _languagesController
                                                            .text,
                                                    appSize: double.tryParse(
                                                        _sizeController.text),
                                                    inAppPurchases:
                                                        _hasInAppPurchases,
                                                  )));
                                            } else {
                                              context
                                                  .read<PreviewBloc>()
                                                  .add(CreatePreview(
                                                      app: App(
                                                    name: _nameController.text,
                                                    subtitle:
                                                        _subtitleController
                                                            .text,
                                                    appSeller:
                                                        _appSellerController
                                                            .text,
                                                    price: double.tryParse(
                                                        _priceController.text),
                                                    version:
                                                        _versionController.text,
                                                    description:
                                                        _descriptionController
                                                            .text,
                                                    whatsNew:
                                                        _whatsNewController
                                                            .text,
                                                    category:
                                                        _categoryController
                                                            .text,
                                                    languages:
                                                        _languagesController
                                                            .text,
                                                    appSize: double.tryParse(
                                                        _sizeController.text),
                                                    inAppPurchases:
                                                        _hasInAppPurchases,
                                                  )));
                                            }
                                          },
                                          child: const Text('Save',
                                              style: TextStyle(fontSize: 20))),
                                    ),
                                  ),
                                  const GutterSmall(),
                                  const Row(children: [AgeRatingPicker()]),
                                  const GutterSmall(),
                                  PriceSwitches(
                                      priceController: _priceController,
                                      isFree: _isFree,
                                      hasInAppPurchases: _hasInAppPurchases),
                                ],
                              ),
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
                    widget.app?.screenshots != null &&
                            widget.app!.screenshots!.isNotEmpty
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
                                          setState(() {
                                            _screenshots += images;
                                          });
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
                        controller: widget._scrollController,
                        child: ListView.builder(
                          itemExtent: 172,
                          itemCount: _screenshots.isNotEmpty &&
                                  widget.app?.screenshots != null &&
                                  widget.app!.screenshots!.isNotEmpty
                              ? _screenshots.length +
                                  widget.app!.screenshots!.length
                              : _screenshots.isNotEmpty
                                  ? _screenshots.length
                                  : widget.app?.screenshots != null &&
                                          widget.app!.screenshots!.isNotEmpty
                                      ? widget.app!.screenshots!.length
                                      : 6,
                          padding: const EdgeInsets.only(bottom: 20.0),
                          controller: widget._scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (widget.app?.screenshots != null &&
                                widget.app!.screenshots!.isNotEmpty &&
                                index < widget.app!.screenshots!.length) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[300]!, width: 1.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.app!.screenshots![index]),
                                        fit: BoxFit.cover),
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              );
                            }
                            if (_screenshots.isNotEmpty) {
                              return FutureBuilder(
                                  future: _screenshots[index].readAsBytes(),
                                  builder: (context, snapshot) {
                                    var data = snapshot.data;
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 1.0),
                                            image: DecorationImage(
                                              image: MemoryImage(data!),
                                            ),
                                          ),
                                        ));
                                  });
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                  height: 370,
                                  width: 800,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: Colors.grey[200],
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(18.0),
                                      onTap: () async {
                                        await ImagePicker()
                                            .pickMultiImage()
                                            .then((images) {
                                          if (images.isNotEmpty) {
                                            setState(() {
                                              _screenshots += images;
                                            });
                                          }
                                          return images;
                                        });
                                      },
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
                                    ),
                                  )),
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
The developer, Christian Vergara, indicated that the app's privacy practices may include handling of data as described below. For more information, see the developer's privacy policy.''',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Seller',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const GutterTiny(),
                                    Text(
                                      _appSellerController.text.isNotEmpty
                                          ? _appSellerController.text
                                          : '???',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                const GutterSmall(),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Category',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const GutterTiny(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                          width: 300,
                                          child: CupertinoTextField(
                                            controller: _categoryController,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            placeholder: 'Category',
                                          )),
                                    ),
                                  ],
                                ),
                                const GutterSmall(),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Languages',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const GutterTiny(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                          width: 300,
                                          child: CupertinoTextField(
                                            controller: _languagesController,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            placeholder: 'Languages',
                                          )),
                                    ),
                                  ],
                                ),
                                const GutterSmall(),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Copyright',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const GutterTiny(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                          width: 300,
                                          child: CupertinoTextField(
                                            controller: _copyRightController,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            placeholder: 'Copyright',
                                          )),
                                    ),
                                  ],
                                ),
                                const GutterSmall(),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('In-App Purchases',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const GutterTiny(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                          width: 300,
                                          child: CupertinoTextField(
                                            controller:
                                                _inAppPurchasesController,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            placeholder: 'In-App Purchases',
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const GutterSmall(),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Size',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                const GutterSmall(),
                                SizedBox(
                                    width: 300,
                                    child: CupertinoTextField(
                                      controller: _sizeController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      placeholder: 'Version',
                                    )),
                                const GutterSmall(),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Compatibiiity',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          const GutterTiny(),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  const Text('iPhone'),
                                                  CupertinoSwitch(
                                                      value: true,
                                                      onChanged: (value) {}),
                                                ],
                                              ),
                                              const GutterSmall(),
                                              Column(
                                                children: [
                                                  const Text('iPad'),
                                                  CupertinoSwitch(
                                                      value: true,
                                                      onChanged: (value) {}),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const GutterSmall(),
                                          Text(
                                            'Minimum iOS Version.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(fontSize: 12.0),
                                          ),
                                          const GutterSmall(),
                                          CupertinoSlidingSegmentedControl(
                                            groupValue: _minimumIOSVersionIndex,
                                            children: const {
                                              0: Text('iOS 12'),
                                              1: Text('iOS 13'),
                                              2: Text('iOS 14'),
                                            },
                                            onValueChanged: (value) {
                                              setState(() {
                                                _minimumIOSVersionIndex =
                                                    value as int;
                                                _minimumIOSVersion =
                                                    _minimumIOSVersions[value];
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gutter(),
                      const Gutter(),
                      const Gutter(),
                      const Row(
                        children: [],
                      ),
                      const Gutter(),
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
