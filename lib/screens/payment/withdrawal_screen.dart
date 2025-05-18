import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ebefa/features/home/screen/view/home.dart';

import '../../models/tickect.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key, required this.tickectModel});
  final TickectModel tickectModel;

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  Future<void> settlement(String amount, String number, String network) async {
    var headers = {
      'Authorization': 'Bearer ${dotenv.env['PAYBOX_API']}',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://paybox.com.co/transfer'));
    request.fields.addAll({
      'currency': 'GHS',
      'amount': amount,
      'mode': 'Mobile Money',
      'mobile_network': network,
      'mobile_number': number,
      //'bank_code': '00110',
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      Get.offAll(() => const MyHomePage());
    } else {
      print(response.reasonPhrase);
      print("Claudious");
    }

    print("${response.statusCode} claudious the goat");
  }

  String convertToLocalFormat(String localNumber) {
    if (localNumber.length <= 10) {
      const countryCode = "+233";
      final cleanNumber = localNumber.replaceAll(RegExp(r'^0+|\D'), '');
      final internationalNumber = countryCode + cleanNumber;
      return internationalNumber;
    } else {
      return localNumber;
    }
  }

  String dropdownValue = "Mtn";

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double earning = widget.tickectModel.earnings! * 0.95;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total Earnings',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 10),
              Text(
                '¢$earning',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              // SizedBox(
              //   width: 300,
              //   child: Column(
              //     children: [
              //       Text(
              //         'Add Mobile Money Account Details',
              //         style: TextStyle(
              //           fontSize: 18,
              //           color: Theme.of(context)
              //               .floatingActionButtonTheme
              //               .backgroundColor,
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //       DropdownButton(items: const [
              //         DropdownMenuItem(
              //           value: "Mtn",
              //           child: Text("MTN"),
              //         ),
              //         DropdownMenuItem(
              //           value: "AirtelTigo",
              //           child: Text("AirtelTigo"),
              //         ),
              //         DropdownMenuItem(
              //           value: "Vodafone",
              //           child: Text("Vodafone"),
              //         )
              //       ], value: dropdownValue, onChanged: dropdownCallback),
              //       const SizedBox(height: 10),
              //       TextField(
              //         minLines: 1,
              //         maxLines: 50,
              //         controller: accountController,
              //         keyboardType: TextInputType.number,
              //         decoration: InputDecoration(
              //           hintText: 'Mobile Money Number',
              //           hintStyle: TextStyle(
              //             color: Theme.of(context)
              //                 .floatingActionButtonTheme
              //                 .backgroundColor,
              //           ),
              //           prefixIcon: const Icon(Icons.account_balance),
              //           border: const OutlineInputBorder(
              //             borderSide: BorderSide(
              //               color: Colors.black,
              //             ),
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(
              //                 15,
              //               ),
              //             ),
              //           ),
              //           enabledBorder: const OutlineInputBorder(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(
              //                 15,
              //               ),
              //             ),
              //             borderSide: BorderSide(
              //               color: Colors.black38,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 10),
              // Button(
              //   screenHeight: screenHeight,
              //   screenWidth: screenWidth,
              //   textName: "Withdraw Earnings",
              //   onPressed: () async {
              //     if (accountController.text.isNotEmpty) {
              //       await settlement(
              //           // '$earning',
              //           "1",
              //           convertToLocalFormat(accountController.text),
              //           dropdownValue);
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
