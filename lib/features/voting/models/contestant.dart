import 'package:cloud_firestore/cloud_firestore.dart';

class ContestantModel {
  static const ADMIN = "admin";
  static const NAME = "name";
  static const PRICE = "price";
  static const CODE = "code";
  static const CATEGORY = "category";
  static const MEDIA = "media";
  static const EVENTNAME = "eventname";
  static const VOTE = "vote";

  final String? admin;
  final String? name;
  final String? price;
  final String? code;
  final String? category;
  final String? vote;
  final String? eventname;
  final List<dynamic>? media;

  ContestantModel({
    this.admin,
    this.name,
    this.price,
    this.code,
    this.category,
    this.vote,
    this.eventname,
    this.media,
  });

  factory ContestantModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final json = documentSnapshot.data()!;

    return ContestantModel(
      name: json[NAME],
      price: json[PRICE],
      admin: json[ADMIN],
      media: json[MEDIA],
      eventname: json[EVENTNAME],
      code: json[CODE],
      category: json[CATEGORY],
      vote: json[VOTE],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      NAME: name,
      PRICE: price,
      ADMIN: admin,
      MEDIA: media,
      EVENTNAME: eventname,
      CODE: code,
      CATEGORY: category,
      VOTE: vote,
    };
  }
}
