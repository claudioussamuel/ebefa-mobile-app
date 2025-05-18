import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/controller.dart';

// this code create a subaccount in paystack

subAccountDetails(String accountName) async {
  var headers = {
    'Authorization': 'Bearer ${dotenv.env['PAYSTACK_API']}',
    'Content-Type': 'application/json'
  };
  var request =
      http.Request('POST', Uri.parse('https://api.paystack.co/subaccount'));
  request.body = json.encode({
    "business_name": accountName
    //ticketController.accountName.text.trim()
    ,
    "settlement_bank": ticketController.selectedBank.value,
    "account_number": ticketController.accountNumber.text.trim(),
    "percentage_charge": 5,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  // print("response status ${response.statusCode}");

  Map<String, dynamic> data;
  if (response.statusCode == 201) {
    //print(await response.stream.bytesToString());
    data = json.decode(await response.stream.bytesToString());
    ticketController.sendAccountNumber.value = data['data']['subaccount_code'];
  } else {
    print(response.reasonPhrase);
  }
}
