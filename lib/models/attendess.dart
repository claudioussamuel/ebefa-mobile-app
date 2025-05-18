class AttendessModel {
  static const ID = "id";
  static const HASATTENDED = "hasAttended";
  static const EMAIL = "email";
  static const NUMBER = "number";
  static const TICKETPRICE = "ticketprice";
  static const TICKETTYPE = "tickettype";
  static const NAME = "name";

  String? email;
  bool? hasAttended;
  String? id;
  String? name;
  String? number;
  String? ticketprice;
  String? tickettype;

  AttendessModel({
    this.email,
    this.id,
    this.name,
    this.number,
    this.ticketprice,
    this.hasAttended,
    this.tickettype,
  });

  AttendessModel.fromJson(Map<String, dynamic> data) {
    id = data[ID];
    name = data[NAME];
    email = data[EMAIL];
    number = data[NUMBER];
    ticketprice = data[TICKETPRICE];

    hasAttended = data[HASATTENDED];
  }

  Map<String, dynamic> toMap() {
    return {
      EMAIL: email,
      ID: id,
      NAME: name,
      NUMBER: number,
      TICKETTYPE: tickettype,
      TICKETPRICE: ticketprice,
      HASATTENDED: hasAttended
    };
  }
}
