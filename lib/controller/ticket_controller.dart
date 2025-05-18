import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebefa/methods/show_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import '../const/firebase.dart';
import '../models/event_media_model.dart';
import '../models/tickect.dart';

class Item {
  String name;
  String price;

  Item(this.name, this.price);
}

class TicketController extends GetxController {
  TextEditingController eventName = TextEditingController();
  TextEditingController eventLocation = TextEditingController();
  TextEditingController eventCity = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController eventAbout = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController tickectPrice = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  Rx<TimeOfDay> startTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> endTime = TimeOfDay.now().obs;
  var selectedBank = 'MTN'.obs;
  RxString sendAccountNumber = ''.obs;
  RxString splitCode = ''.obs;
  RxList<Map<String, dynamic>> mediaUrls = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> tickets = <Map<String, dynamic>>[].obs;
  RxList<EventMediaModel> media = <EventMediaModel>[].obs;
  Rx<int> numberOfItems = 1.obs;
  RxList<Item> items = [Item('', '')].obs;

  static TicketController instance = Get.find();

  String collection = "admin";

  // add tickects to admin side only
  Future<void> addTicket(TickectModel tickectModel) {
    return firebaseFirestore
        .collection(collection)
        .doc(auth.currentUser?.uid)
        .collection(
          'tickets',
        )
        .doc(tickectModel.id)
        .set(tickectModel.toMap());
  }

  //update the array in firebase
  verifyTickets(TickectModel tickectModel, String id) {
    var document = firebaseFirestore.collection('tickets').doc(tickectModel.id);

    document.get().then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data()!;

      List<Map<String, dynamic>> users =
          List<Map<String, dynamic>>.from(data['users']);

      int indexToUpdate = users.indexWhere((user) => user['id'] == id);
      if (indexToUpdate != -1) {
        users[indexToUpdate]['hasAttended'] = true;
      }
      document.set({
        'users': users,
      }, SetOptions(merge: true));
      // document.update({'users': FieldValue.arrayUnion(users)});
    });
    showSuccess();
  }

  //addd tickets to user side
  Future<void> addAllTicket(TickectModel tickectModel) {
    return firebaseFirestore
        .collection(
          'tickets',
        )
        .doc(tickectModel.id)
        .set(
          tickectModel.toMap(),
        );
  }

  // delete for user
  Future<void> removeTickectsUser(TickectModel tickectModel) {
    return firebaseFirestore
        .collection(
          'tickets',
        )
        .doc(tickectModel.id)
        .delete();
  }

  // delete for admin

  Future<void> removeTickectsAdmin(TickectModel tickectModel) {
    return firebaseFirestore
        .collection(collection)
        .doc(auth.currentUser?.uid)
        .collection(
          'tickets',
        )
        .doc(tickectModel.id)
        .delete();
  }

  Future<void> removeImageFromFirebaseStorage(TickectModel tickectModel) async {
    try {
      firebaseStorage
          .ref(
            'files/${tickectModel.path}',
          )
          .delete();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<String> uploadImageToFirebase(File file) async {
    String fileUrl = '';
    String fileName = path.basename(file.path);
    var reference = FirebaseStorage.instance.ref().child('files/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    return fileUrl;
  }

  Future<String> uploadThumbnailToFirebase(Uint8List file) async {
    String fileUrl = '';
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child('files/$fileName.jpg');
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    return fileUrl;
  }

  Future<List<TickectModel>> getListOfTickets() async {
    var snapshot = await firebaseFirestore
        // .collection(
        //   collection,
        // )
        // .doc(auth.currentUser?.uid)
        .collection('tickets')
        .where('adminId', isEqualTo: "${auth.currentUser?.uid}")
        .get();

    final tickets = snapshot.docs.map((e) => TickectModel.fromMap(e)).toList();

    return tickets;
  }

  // New Way of using stream to fetch the data from firebase
  Stream<Iterable<TickectModel>> allTickets() {
    final snapshot = firebaseFirestore
        .collection('tickets')
        .where('adminId', isEqualTo: "${auth.currentUser?.uid}")
        .snapshots()
        .map((event) => event.docs.map((doc) => TickectModel.fromMap(doc)));

    return snapshot;
  }

  Future<void> updateTicket(TickectModel tickectModel) async {
    await firebaseFirestore
        .collection(
          "tickets",
        )
        .doc(
          tickectModel.id,
        )
        .update(
          tickectModel.toMap(),
        );
  }

  clearControllers() {
    eventName.clear();
    eventAbout.clear();
    eventCity.clear();
    eventLocation.clear();
    phoneNumber.clear();
    accountName.clear();
    accountNumber.clear();
    tickectPrice.clear();
  }
}
