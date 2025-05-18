import 'package:ebefa/features/voting/models/contestant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/controller.dart';
import '../../../const/firebase.dart';
import '../../../methods/show_loading.dart';
import '../../../models/event_media_model.dart';
import '../models/voting.dart';
import '../screens/home.dart';

class VoteController extends GetxController {
  static VoteController instance = Get.find();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  Rx<DateTime> date = DateTime.now().obs;
  RxList<EventMediaModel> votingMedia = <EventMediaModel>[].obs;
  RxList<TextEditingController> listController = <TextEditingController>[].obs;
  RxList<String> categories = <String>[].obs;
  RxList<Map<String, dynamic>> mediaUrls = <Map<String, dynamic>>[].obs;
  TextEditingController contestantName = TextEditingController();
  TextEditingController votingCode = TextEditingController();
  var category = ''.obs;

  String collection = "voting";
  String ussd = "ussd";

  Future<void> addVoting({required VotingModel votingModel}) {
    return firebaseFirestore
        .collection(
          collection,
        )
        .doc()
        .set(
          votingModel.toMap(),
        );
  }

  Future<void> addContestant({required ContestantModel contestantModel}) {
    return firebaseFirestore
        .collection(
          ussd,
        )
        .doc()
        .set(
          contestantModel.toMap(),
        );
  }

  void submit() async {
    if (name.text.isEmpty && price.text.isEmpty && votingMedia.isEmpty) {
      Get.snackbar(
        "Opps",
        "Media is required",
      );
      return;
    }
    showLoading();

    for (var i = 0; i < listController.length; i++) {
      categories.add(listController[i].text.trim());
    }

    if (votingMedia.isNotEmpty) {
      for (var i = 0; i < votingMedia.length; i++) {
        if (votingMedia[i].isVideo!) {
          String thumbnailUrl =
              await ticketController.uploadThumbnailToFirebase(
            votingMedia[i].thumbnail!,
          );

          String videoUrl = await ticketController.uploadImageToFirebase(
            votingMedia[i].video!,
          );

          mediaUrls.add(
              {'url': videoUrl, 'thumbnail': thumbnailUrl, 'isImage': false});
        } else {
          String imageUrl = await ticketController.uploadImageToFirebase(
            votingMedia[i].image!,
          );

          mediaUrls.add({
            'url': imageUrl,
            "isImage": true,
          });
        }
      }
    }

    addVoting(
        votingModel: VotingModel(
      admin: authController.firebaseUser.value?.uid,
      date: DateTime(date.value.year, date.value.month, date.value.day,
          date.value.hour, date.value.minute),
      name: name.text.trim(),
      price: price.text.trim(),
      categories: categories,
      media: mediaUrls,
    ));

    Get.off(() => const VotingHome());
    name.clear();
    price.clear();
    mediaUrls.clear();
  }

  void submitContestant(
      {required String eventName,
      required String eventPrice,
      required BuildContext context}) async {
    if (name.text.isEmpty && price.text.isEmpty && votingMedia.isEmpty) {
      Get.snackbar(
        "Opps",
        "Media is required",
      );
      return;
    }
    showLoading();

    for (var i = 0; i < listController.length; i++) {
      categories.add(listController[i].text.trim());
    }

    if (votingMedia.isNotEmpty) {
      for (var i = 0; i < votingMedia.length; i++) {
        if (votingMedia[i].isVideo!) {
          String thumbnailUrl =
              await ticketController.uploadThumbnailToFirebase(
            votingMedia[i].thumbnail!,
          );

          String videoUrl = await ticketController.uploadImageToFirebase(
            votingMedia[i].video!,
          );

          mediaUrls.add(
              {'url': videoUrl, 'thumbnail': thumbnailUrl, 'isImage': false});
        } else {
          String imageUrl = await ticketController.uploadImageToFirebase(
            votingMedia[i].image!,
          );

          mediaUrls.add({
            'url': imageUrl,
            "isImage": true,
          });
        }
      }
    }

    addContestant(
        contestantModel: ContestantModel(
      admin: authController.firebaseUser.value?.uid,
      name: contestantName.text.trim(),
      price: eventPrice,
      media: mediaUrls,
      category: category.value,
      eventname: eventName,
      code: votingCode.text.trim(),
      vote: "0",
    )
        //     votingModel: VotingModel(
        //   admin: authController.firebaseUser.value?.uid,
        //   date: DateTime(date.value.year, date.value.month, date.value.day,
        //       date.value.hour, date.value.minute),
        //   name: name.text.trim(),
        //   price: price.text.trim(),
        //   categories: categories,
        //   media: mediaUrls,
        // )
        );

    contestantName.clear();
    votingCode.clear();
    mediaUrls.clear();
    Navigator.pop(context);
    Get.back();
  }

  Stream<Iterable<VotingModel>> getListOfVoting() {
    var snapshot = firebaseFirestore
        .collection(collection)
        .where('admin', isEqualTo: "${auth.currentUser?.uid}")
        .snapshots();

    final voting =
        snapshot.map((e) => e.docs.map((e) => VotingModel.fromMap(e)));

    return voting;
  }

  Stream<Iterable<ContestantModel>> getListOfContestant(
      {required String name}) {
    var snapshot = firebaseFirestore
        .collection(ussd)
        .where('admin', isEqualTo: "${auth.currentUser?.uid}")
        .where('eventname', isEqualTo: name)
        .snapshots();

    final voting =
        snapshot.map((e) => e.docs.map((e) => ContestantModel.fromMap(e)));

    return voting;
  }
}
