import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/firebase.dart';
import '../../../models/admin.dart';
import '../../../utils/navigation_bar.dart';
import '../../home/screen/view/home.dart';
import '../screens/onboarding/onboarding.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  var nameController = "".obs;
  var emailController = "".obs;
  var passwordController = "".obs;
  TextEditingController forgetPword = TextEditingController();
  var adminModel = AdminModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  void signOut() async {
    auth.signOut();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const OnBoardingScreen());
    } else {
      adminModel.bindStream(listenToUser());
      Get.offAll(() => const NavigationMenu()
          // MyHomePage()
          );
    }
  }

  void signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.value,
        password: passwordController.value,
      );
      Get.offAll(() => const NavigationMenu()
          // MyHomePage() NavigationMenu()
          );
      // _clearControllers();
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Sign In Failed',
        'Try again',
      );
    }
  }

  void signUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: emailController.value.trim(),
        password: passwordController.value.trim(),
      )
          .then((result) {
        String userId = result.user!.uid;

        setUser(AdminModel(
          name: nameController.value.trim(),
          email: emailController.value.trim(),
          id: userId,
        ));
        //  _clearControllers();
      });
      Get.offAll(() => const NavigationMenu()
          //  MyHomePage()
          );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Sign Up Failed',
        'Try again',
      );
    }
  }

  // _clearControllers() {
  //   nameController.clear();
  //   email.clear();
  //   password.clear();
  // }

  ///====== getting all the users who
  ///created account name and email

  Stream<AdminModel> listenToUser() => firebaseFirestore
      .collection('admin')
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => AdminModel.fromJson(snapshot));

  //======= Set new user =======
  Future<void> setUser(AdminModel adminModel) {
    return firebaseFirestore
        .collection('admin')
        .doc(adminModel.id)
        .set(adminModel.toMap());
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.snackbar(
        "Email Sent",
        "We have sent password reset to email",
      );
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
