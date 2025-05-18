import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading() {
  Get.defaultDialog(
    title: "Loading...",
    content: const CircularProgressIndicator(),
    barrierDismissible: false,
  );
}

showSuccess() {
  Get.defaultDialog(
      title: "Success",
      content: const Text("Ticket has been Successfully Verified"),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text("OK"),
        )
      ]);
}

showFailure() {
  Get.defaultDialog(
      title: "Error",
      content: const Text("Invalid Ticket"),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text("OK"),
        )
      ]);
}
