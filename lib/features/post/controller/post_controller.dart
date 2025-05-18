import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../const/controller.dart';
import '../../../methods/show_loading.dart';
import '../../../models/tickect.dart';
import '../../home/screen/view/home.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();
  final pageController = PageController();
  Rx<int> currentPage = 0.obs;
  void updatePageIndicator(index) {
    currentPage.value = index;
  }

  void dotNavigation(index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() async {
    if (currentPage.value == 2) {
      if (ticketController.media.isEmpty &&
          ticketController.eventCity.text.isEmpty &&
          ticketController.phoneNumber.text.isEmpty &&
          ticketController.eventAbout.text.isEmpty &&
          ticketController.eventName.text.isEmpty &&
          ticketController.eventLocation.text.isEmpty) {
        Get.snackbar(
          "Opps",
          "Media is required",
        );
        return;
      }
      showLoading();

      for (var i = 0; i < ticketController.items.length; i++) {
        ticketController.tickets.add({
          "splitaccount": ticketController.splitCode.value,
          "subaccount": ticketController.sendAccountNumber.value,
          "name": ticketController.items[i].name,
          "price": ticketController.items[i].price
        });
      }

      if (ticketController.media.isNotEmpty) {
        for (var i = 0; i < ticketController.media.length; i++) {
          if (ticketController.media[i].isVideo!) {
            String thumbnailUrl =
                await ticketController.uploadThumbnailToFirebase(
              ticketController.media[i].thumbnail!,
            );

            String videoUrl = await ticketController.uploadImageToFirebase(
              ticketController.media[i].video!,
            );

            ticketController.mediaUrls.add(
                {'url': videoUrl, 'thumbnail': thumbnailUrl, 'isImage': false});
          } else {
            String imageUrl = await ticketController.uploadImageToFirebase(
              ticketController.media[i].image!,
            );

            ticketController.mediaUrls.add({
              'url': imageUrl,
              "isImage": true,
            });
          }
        }
      }

      ticketController.addAllTicket(
        TickectModel(
          adminId: authController.firebaseUser.value?.uid,
          city: ticketController.eventCity.text.trim(),
          contact: ticketController.phoneNumber.text.trim(),
          description: ticketController.eventAbout.text.trim(),
          id: ticketController.eventName.text.trim(),
          location: ticketController.eventLocation.text.trim(),
          media: ticketController.mediaUrls,
          typeTickets: ticketController.tickets,
          name: ticketController.eventName.text.trim(),
          startdate: DateTime(
            ticketController.startDate.value.year,
            ticketController.startDate.value.month,
            ticketController.startDate.value.day,
            ticketController.startTime.value.hour,
            ticketController.startTime.value.minute,
          ),
          enddate: DateTime(
            ticketController.endDate.value.year,
            ticketController.endDate.value.month,
            ticketController.endDate.value.day,
            ticketController.endTime.value.hour,
            ticketController.endTime.value.minute,
          ),
          earnings: 0,
        ),
      );

      Get.offAll(const MyHomePage());
      ticketController.clearControllers();
    } else {
      int page = currentPage.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPage.value = 2;
    pageController.jumpToPage(2);
  }
}
