import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../const/controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/size.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../../utils/device/device_utility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = TDeviceUtils.getMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title

              Text(
                TText.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //Form
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      expands: false,
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: TText.firstName,
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TextFormField(
                      expands: false,
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: TText.email,
                        prefixIcon: Icon(
                          Iconsax.direct,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TextFormField(
                      expands: false,
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                        labelText: TText.password,
                        prefixIcon: Icon(
                          Iconsax.password_check,
                        ),
                        suffixIcon: Icon(
                          Iconsax.eye_slash,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: TText.iAgreeTo,
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium,
                              ),
                              TextSpan(
                                text: TText.privacyPolicy,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                      color: dark
                                          ? TColors.black
                                          : TColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? TColors.black
                                          : TColors.primary,
                                    ),
                              ),
                              TextSpan(
                                text: TText.and,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              TextSpan(
                                text: TText.termsAndConditions,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                      color:
                                          dark ? TColors.dark : TColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          dark ? TColors.dark : TColors.primary,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          authController.nameController.value =
                              name.text.trim();
                          authController.passwordController.value =
                              password.text.trim();
                          authController.emailController.value =
                              email.text.trim();
                          authController.signUp();
                        },
                        child: const Text(TText.signUp),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
