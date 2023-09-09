class App {
  String? title;
  String? subtitle;
  String? appIcon;
  String? appSeller;
  double? price;
  bool? inAppPurchases;
  int? ageRating;
  List<String>? screenshots;
  String? description;
  String? whatsNew;
  String? version;
  double? appSize;
  String? category;
  String? compatibility;
  String? languages;
  String? copyright;

  App({
    this.title,
    this.subtitle,
    this.appIcon,
    this.appSeller,
    this.price,
    this.inAppPurchases,
    this.ageRating,
    this.screenshots,
    this.description,
    this.whatsNew,
    this.version,
    this.appSize,
    this.category,
    this.compatibility,
    this.languages,
    this.copyright,
  });

  App copyWith({
    String? title,
    String? subtitle,
    String? appIcon,
    String? appSeller,
    double? price,
    bool? inAppPurchases,
    int? ageRating,
    List<String>? screenshots,
    String? description,
    String? whatsNew,
    String? version,
    double? appSize,
    String? category,
    String? compatibility,
    String? languages,
    String? copyRight,
  }) {
    return App(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      appIcon: appIcon ?? this.appIcon,
      appSeller: appSeller ?? this.appSeller,
      price: price ?? this.price,
      inAppPurchases: inAppPurchases ?? this.inAppPurchases,
      ageRating: ageRating ?? this.ageRating,
      screenshots: screenshots ?? this.screenshots,
      description: description ?? this.description,
      whatsNew: whatsNew ?? this.whatsNew,
      version: version ?? this.version,
      appSize: appSize ?? this.appSize,
      category: category ?? this.category,
      compatibility: compatibility ?? this.compatibility,
      languages: languages ?? this.languages,
    );
  }
}
