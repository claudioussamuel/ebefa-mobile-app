import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ebefa/features/authentications/controllers/auth_controller.dart';
import 'package:ebefa/features/authentications/controllers/onboarding_controller.dart';
import 'package:ebefa/features/authentications/screens/onboarding/onboarding.dart';
import 'controller/ticket_controller.dart';
import 'features/post/controller/post_controller.dart';
import 'features/voting/controllers/vote_controllers.dart';
import 'utils/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthController());
    Get.put(TicketController());
    Get.put(OnboardingController());
    Get.put(PostController());
    Get.put(VoteController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EBEFA',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}
