import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../const/controller.dart';

splitPayment(String subaccount, String name) async {
  var headers = {
    'Authorization': 'Bearer ${dotenv.env['PAYSTACK_API']}',
    'Content-Type': 'application/json'
  };

  var request =
      http.Request('POST', Uri.parse('https://api.paystack.co/split'));
  request.body = json.encode({
    "name": name,
    "type": "percentage",
    "currency": "GHS",
    "subaccounts": [
      {
        "subaccount": subaccount,
        "share": 96,
      },
    ],
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  Map<String, dynamic> data;
  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    data = json.decode(await response.stream.bytesToString());
    ticketController.splitCode.value = data['data']['split_code'];
  } else {
    print(response.reasonPhrase);
  }
}
