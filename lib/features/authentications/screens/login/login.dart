import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ebefa/const/controller.dart';
import 'package:ebefa/features/authentications/screens/signup/signup.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/size.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../../utils/device/device_utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = TDeviceUtils.getMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  width: 100,
                  image: AssetImage(
                    dark ? TImage.lightApplogo : TImage.darkApplogo,
                  ),
                ),
                Text(
                  TText.loginTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                Text(
                  TText.loginSubTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            //Forms
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems),
              child: Form(
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: TText.email,
                        prefixIcon: Icon(
                          Iconsax.direct_right,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    // Password
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: TText.password,
                        prefixIcon: Icon(
                          Iconsax.password_check,
                        ),
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    // Remember me and forget Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember me
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                            ),
                            const Text(TText.rememberMe),
                          ],
                        ),
                        // Forget Password

                        TextButton(
                          onPressed: () {},
                          child: const Text(TText.forgetPassword),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          authController.passwordController.value =
                              password.text.trim();
                          authController.emailController.value =
                              email.text.trim();
                          authController.signIn();
                        },
                        child: const Text(TText.signIn),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    //Login
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(
                            () => const SignUpScreen(),
                          );
                        },
                        child: const Text(TText.createAccount),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Flexible(
            //       child: Divider(
            //         color: dark ? TColors.grey : TColors.darkGrey,
            //         thickness: 0.5,
            //         indent: 60,
            //         endIndent: 5,
            //       ),
            //     ),
            //     Flexible(
            //       child: Divider(
            //         color: dark ? TColors.grey : TColors.darkGrey,
            //         thickness: 0.5,
            //         indent: 5,
            //         endIndent: 60,
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
