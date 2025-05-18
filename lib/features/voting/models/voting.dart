import 'package:cloud_firestore/cloud_firestore.dart';

class VotingModel {
  static const ADMIN = "admin";
  static const NAME = "name";
  static const PRICE = "price";
  static const DATE = "date";
  static const CATEGORIES = "categories";
  static const MEDIA = "media";

  final String? name;
  final String? price;
  final DateTime? date;
  final List<dynamic>? categories;
  final String? admin;
  final List<dynamic>? media;

  VotingModel({
    this.media,
    this.name,
    this.price,
    this.date,
    this.categories,
    this.admin,
  });

  factory VotingModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final json = documentSnapshot.data()!;

    return VotingModel(
      name: json[NAME],
      price: json[PRICE],
      date: json[DATE].toDate(),
      categories: json[CATEGORIES],
      admin: json[ADMIN],
      media: json[MEDIA],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      NAME: name,
      PRICE: price,
      DATE: date,
      CATEGORIES: categories,
      ADMIN: admin,
      MEDIA: media,
    };
  }
}
