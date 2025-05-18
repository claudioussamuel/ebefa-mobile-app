import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";

  String? id;
  String? name;
  String? email;

  AdminModel({
    this.email,
    this.id,
    this.name,
  });

  AdminModel.fromJson(DocumentSnapshot data) {
    id = data[ID];
    name = data[NAME];
    email = data[EMAIL];
  }

  Map<String, dynamic> toMap() {
    return {
      EMAIL: email,
      ID: id,
      NAME: name,
    };
  }
}
