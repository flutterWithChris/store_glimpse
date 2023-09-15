import 'package:cloud_firestore/cloud_firestore.dart';

class App {
  String? id;
  String? name;
  String? subtitle;
  String? appIcon;
  String? appSeller;
  double? price;
  bool? inAppPurchases;
  String? ageRating;
  List<String>? screenshots;
  String? description;
  String? whatsNew;
  String? version;
  String? minimumIOSVersion;
  double? appSize;
  String? category;
  String? compatibility;
  String? languages;
  String? copyright;

  App({
    this.id,
    this.name,
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
    this.minimumIOSVersion,
    this.appSize,
    this.category,
    this.compatibility,
    this.languages,
    this.copyright,
  });

  App copyWith({
    String? id,
    String? name,
    String? subtitle,
    String? appIcon,
    String? appSeller,
    double? price,
    bool? inAppPurchases,
    String? ageRating,
    List<String>? screenshots,
    String? description,
    String? whatsNew,
    String? version,
    String? minimumIOSVersion,
    double? appSize,
    String? category,
    String? compatibility,
    String? languages,
    String? copyRight,
  }) {
    return App(
      id: id ?? this.id,
      name: name ?? this.name,
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
      minimumIOSVersion: minimumIOSVersion ?? this.minimumIOSVersion,
      appSize: appSize ?? this.appSize,
      category: category ?? this.category,
      compatibility: compatibility ?? this.compatibility,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'appIcon': appIcon,
      'appSeller': appSeller,
      'price': price,
      'inAppPurchases': inAppPurchases,
      'ageRating': ageRating,
      'screenshots': screenshots,
      'description': description,
      'whatsNew': whatsNew,
      'version': version,
      'minimumIOSVersion': minimumIOSVersion,
      'appSize': appSize,
      'category': category,
      'compatibility': compatibility,
      'languages': languages,
    };
  }

  factory App.fromDocument(DocumentSnapshot doc) {
    return App(
      id: doc['id'],
      name: doc['name'],
      subtitle: doc['subtitle'],
      appIcon: doc['appIcon'],
      appSeller: doc['appSeller'],
      price: doc['price'],
      inAppPurchases: doc['inAppPurchases'],
      ageRating: doc['ageRating'],
      screenshots: doc['screenshots'],
      description: doc['description'],
      whatsNew: doc['whatsNew'],
      version: doc['version'],
      minimumIOSVersion: doc['minimumIOSVersion'],
      appSize: doc['appSize'],
      category: doc['category'],
      compatibility: doc['compatibility'],
      languages: doc['languages'],
    );
  }
}
