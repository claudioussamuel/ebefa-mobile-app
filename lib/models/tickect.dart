import 'package:cloud_firestore/cloud_firestore.dart';

class TickectModel {
  static const ID = "id";
  static const NAME = "name";
  static const MEDIA = "media";
  static const DESCRIPTION = "description";
  static const LOCATION = "location";
  static const CITY = "city";
  static const START_DATE = "startdate";
  static const END_DATE = "enddate";
  static const USERS = "users";
  static const ADMINID = 'adminId';
  static const PATH = "path";
  static const SUBACCOUNTNUMBER = 'subaccountnumber';
  static const CONTACT = 'contact';
  static const SPLIT_CODE = 'splitcode';
  static const TYPEOFTICKET = 'typeofticket';
  static const DISCOUNT = 'discount';
  static const DISCOUNT_START = 'discountstart';
  static const DISCOUNT_END = 'discountend';
  static const TOTAL_EARNINGS = 'earnings';

  final double? earnings;
  final String? id;
  final String? name;
  final DateTime? discountStart;
  final DateTime? discountEnd;
  final List<dynamic>? media;
  final List<dynamic>? users;
  final List<dynamic>? typeTickets;
  final String? description;
  final String? city;
  final double? discount;
  final String? location;
  final DateTime? startdate;
  final DateTime? enddate;
  final String? path;
  final String? contact;
  final String? adminId;

  TickectModel({
    this.typeTickets,
    this.discount,
    this.users,
    this.discountStart,
    this.discountEnd,
    this.id,
    this.name,
    this.media,
    this.description,
    this.city,
    this.location,
    this.enddate,
    this.startdate,
    this.path,
    this.adminId,
    this.contact,
    this.earnings,
  });

  factory TickectModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final json = documentSnapshot.data()!;
    return TickectModel(
      id: json[ID],
      name: json[NAME],
      startdate: json[START_DATE].toDate(),
      enddate: json[END_DATE].toDate(),
      media: json[MEDIA],
      description: json[DESCRIPTION],
      city: json[CITY],
      location: json[LOCATION],
      path: json[PATH],
      discount: json[DISCOUNT],
      typeTickets: json[TYPEOFTICKET],
      adminId: json[ADMINID],
      contact: json[CONTACT],
      users: json[USERS],
      earnings: json[TOTAL_EARNINGS],
      // discountEnd: json[DISCOUNT_END],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ID: id,
      NAME: name,
      START_DATE: startdate,
      END_DATE: enddate,
      MEDIA: media,
      DESCRIPTION: description,
      DISCOUNT: discount,
      TYPEOFTICKET: typeTickets,
      CITY: city,
      LOCATION: location,
      ADMINID: adminId,
      PATH: path,
      CONTACT: contact,
      USERS: users,
      DISCOUNT_START: discountStart,
      DISCOUNT_END: discountEnd,
      TOTAL_EARNINGS: earnings,
    };
  }
}
