import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ebefa/const/controller.dart';
import '../../controller/ticket_controller.dart';
import '../../utils/constants/size.dart';

// class Item {
//   String name;
//   String price;

//   Item(this.name, this.price);
// }

class EventPricing extends StatefulWidget {
  const EventPricing({super.key});

  @override
  State<EventPricing> createState() => _EventPricingState();
}

class _EventPricingState extends State<EventPricing> {
  // int numberOfItems = 1;
  // List<Item> items = [Item('', '')];
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  @override
  void dispose() {
    // ticketController.eventCity.dispose();
    // ticketController.phoneNumber.dispose();
    // ticketController.eventAbout.dispose();
    // ticketController.eventName.dispose();
    // ticketController.eventLocation.dispose();
    // ticketController.eventName.dispose();
    super.dispose();
  }

  // bool isSwitched = false;
  // List<String> bankName = [
  //   'Absa Bank Ghana Ltd',
  //   'Access Bank',
  //   'ADB Bank Limited',
  //   'AirtelTigo',
  //   'ARB Apex Bank',
  //   'Bank of Africa Ghana',
  //   'Bank of Baroda Ghana Limited',
  //   'Bank of Ghana',
  //   'Barclays Bank of Ghana Limited',
  //   'BSIC Ghana Limited',
  //   'CAL Bank Limited',
  //   'Consolidated Bank Ghana Limited',
  //   'Ecobank Ghana Limited',
  //   'Energy Bank Ghana Limited',
  //   'FBNBank Ghana Limited',
  //   'Fidelity Bank Ghana Limited',
  //   'First Atlantic Bank Ghana Limited',
  //   'First National Bank Ghana Limited',
  //   'GCB Bank Limited',
  //   'GHL Bank',
  //   'Gn Bank',
  //   'Guaranty Trust Bank (Ghana) Limited',
  //   'Heritage Bank Ghana',
  //   'HFC Bank Ghana Limited',
  //   'MTN',
  //   'National Investment Bank Limited',
  //   'OmniBank Ghana Limited',
  //   'Premium Bank Limited',
  //   'Prudebtial Bank Limited',
  //   'Services Integrity Savings and Loans',
  //   'Sovereign Bank Ghana',
  //   'Stanbic Bank Ghana Limited',
  //   'Standard Chartered Bank Limited',
  //   'The Royal Bank Limited',
  //   'UniBank Ghana Limited',
  //   'United Bank for Africa Ghana Limited',
  //   'Universal Merchant Bank Ghana Limited',
  //   'Vodafone',
  //   'Zenith Bank Ghana',
  // ];

  // void toggleSwitch(bool value) {
  //   setState(() {
  //     isSwitched = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Price Info",
            style: Theme.of(
              context,
            ).textTheme.titleLarge,
          ),
          elevation: 1,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight * 0.85,
            child: Column(
              children: [
                // DropdownButton<String>(
                //   value: ticketController.selectedBank.value,
                //   hint: const Text('Select a Bank'),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       ticketController.selectedBank.value = newValue ?? "MTN";
                //     });
                //   },
                //   items: bankName.map((String bank) {
                //     return DropdownMenuItem<String>(
                //       value: bank,
                //       child: Text(bank),
                //     );
                //   }).toList(),
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // TextField(
                //   minLines: 1,
                //   maxLines: 50,
                //   controller: ticketController.accountName,
                //   decoration: const InputDecoration(
                //     labelText: 'Account name / Momo Name',
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.black,
                //       ),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(
                //           15,
                //         ),
                //       ),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(
                //           15,
                //         ),
                //       ),
                //       borderSide: BorderSide(
                //         color: Colors.black38,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // TextField(
                //   minLines: 1,
                //   maxLines: 50,
                //   controller: ticketController.accountNumber,
                //   decoration: const InputDecoration(
                //     labelText: 'Account number / Momo number',
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.black,
                //       ),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(
                //           15,
                //         ),
                //       ),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(
                //           15,
                //         ),
                //       ),
                //       borderSide: BorderSide(
                //         color: Colors.black38,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                DropdownButton<int>(
                  value: ticketController.numberOfItems.value,
                  items: List.generate(10, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                        '${index + 1} Types Of Ticket',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }),
                  onChanged: (value) {
                    setState(
                      () {
                        ticketController.numberOfItems.value = value!;
                        ticketController.items.value = List<Item>.generate(
                          ticketController.numberOfItems.value,
                          (index) => Item('', ''),
                        );
                      },
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ticketController.numberOfItems.value,
                    itemBuilder: (context, index) {
                      return Form(
                        child: Column(
                          children: [
                            TextFormField(
                              expands: false,
                              onChanged: (text) {
                                ticketController.items[index].name =
                                    text.trim();
                              },
                              decoration: const InputDecoration(
                                labelText: 'Name of Type',
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            TextFormField(
                              expands: false,
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                ticketController.items[index].price =
                                    text.trim();
                              },
                              decoration: const InputDecoration(
                                labelText: 'Price of Type',
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                          ],
                        ),
                      );
                      // return Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Column(
                      //     children: [
                      //       TextField(
                      //         minLines: 1,
                      //         maxLines: 50,
                      //         onChanged: (text) {
                      //           items[index].name = text;
                      //         },
                      //         // controller: controller,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Name of Type',
                      //           border: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Colors.black,
                      //             ),
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(
                      //                 15,
                      //               ),
                      //             ),
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
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
                      //       const SizedBox(
                      //         height: 8,
                      //       ),
                      //       TextField(
                      //         minLines: 1,
                      //         maxLines: 50,
                      //         onChanged: (text) {
                      //           items[index].price = text;
                      //         },
                      //         keyboardType: TextInputType.number,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Price of Ticket',
                      //           border: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Colors.black,
                      //             ),
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(
                      //                 15,
                      //               ),
                      //             ),
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
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
                      //       const SizedBox(
                      //         height: 5,
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                  ),
                ),

                // Text(
                //   'Do you want to add discount ?',
                //   style: Theme.of(
                //     context,
                //   ).textTheme.displayMedium,
                // ),
                // Switch(
                //   value: isSwitched,
                //   onChanged: toggleSwitch,
                //   activeColor: Theme.of(
                //     context,
                //   ).floatingActionButtonTheme.backgroundColor,
                //   activeTrackColor: Colors.green,
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // !isSwitched
                //     ? Container()
                //     : Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             TextField(
                //               minLines: 1,
                //               maxLines: 50,
                //               onChanged: (text) {},
                //               keyboardType: TextInputType.number,
                //               controller: ticketController.discount,
                //               decoration: const InputDecoration(
                //                 labelText: 'Enter the Percentage off',
                //                 border: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Colors.black,
                //                   ),
                //                   borderRadius: BorderRadius.all(
                //                     Radius.circular(
                //                       15,
                //                     ),
                //                   ),
                //                 ),
                //                 enabledBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.all(
                //                     Radius.circular(
                //                       15,
                //                     ),
                //                   ),
                //                   borderSide: BorderSide(
                //                     color: Colors.black38,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(
                //               height: 5,
                //             ),
                //             buildStartDateField(context),
                //             buildStartTimeFeild(context),
                //             buildEndDateField(context),
                //             buildEndTimeFeild(context)
                //           ],
                //         ),
                //       ),

                // Button(
                //   screenHeight: screenHeight,
                //   screenWidth: screenWidth,
                //   textName: 'Submit',
                //   onPressed: () async {
                //     if (ticketController.media.isEmpty &&
                //         ticketController.eventCity.text.isEmpty &&
                //         ticketController.phoneNumber.text.isEmpty &&
                //         ticketController.eventAbout.text.isEmpty &&
                //         ticketController.eventName.text.isEmpty &&
                //         ticketController.eventLocation.text.isEmpty) {
                //       Get.snackbar(
                //         "Opps",
                //         "Media is required",
                //       );
                //       return;
                //     }
                //     showLoading();

                //     for (var i = 0; i < items.length; i++) {
                //       // String eventname =
                //       //     "${ticketController.eventName.text.trim()} ${items[i].name}";
                //       //subAccountDetails(eventname).whenComplete(() {
                //       //   splitPayment(ticketController.sendAccountNumber.value,
                //       //       eventname);
                //       //     .whenComplete(() {
                //       ticketController.tickets.add({
                //         "splitaccount": ticketController.splitCode.value,
                //         "subaccount": ticketController.sendAccountNumber.value,
                //         "name": items[i].name,
                //         "price": items[i].price
                //       });
                //       // });
                //       // });
                //     }

                //     if (ticketController.media.isNotEmpty) {
                //       for (var i = 0; i < ticketController.media.length; i++) {
                //         if (ticketController.media[i].isVideo!) {
                //           String thumbnailUrl =
                //               await ticketController.uploadThumbnailToFirebase(
                //             ticketController.media[i].thumbnail!,
                //           );

                //           String videoUrl =
                //               await ticketController.uploadImageToFirebase(
                //             ticketController.media[i].video!,
                //           );

                //           ticketController.mediaUrls.add({
                //             'url': videoUrl,
                //             'thumbnail': thumbnailUrl,
                //             'isImage': false
                //           });
                //         } else {
                //           String imageUrl =
                //               await ticketController.uploadImageToFirebase(
                //             ticketController.media[i].image!,
                //           );

                //           ticketController.mediaUrls.add({
                //             'url': imageUrl,
                //             "isImage": true,
                //           });
                //         }
                //       }
                //     }

                //     ticketController.addAllTicket(
                //       TickectModel(
                //         adminId: authController.firebaseUser.value?.uid,
                //         city: ticketController.eventCity.text,
                //         contact: ticketController.phoneNumber.text,
                //         description: ticketController.eventAbout.text,
                //         id: ticketController.eventName.text,
                //         location: ticketController.eventLocation.text,
                //         media: ticketController.mediaUrls,
                //         typeTickets: ticketController.tickets,
                //         name: ticketController.eventName.text,
                //         startdate: DateTime(
                //           ticketController.startDate.value.year,
                //           ticketController.startDate.value.month,
                //           ticketController.startDate.value.day,
                //           ticketController.startTime.value.hour,
                //           ticketController.startTime.value.minute,
                //         ),
                //         enddate: DateTime(
                //           ticketController.endDate.value.year,
                //           ticketController.endDate.value.month,
                //           ticketController.endDate.value.day,
                //           ticketController.endTime.value.hour,
                //           ticketController.endTime.value.minute,
                //         ),
                //         // discount: ticketController.discount.text.isEmpty
                //         //     ? 100
                //         //     : double.parse(
                //         //         ticketController.discount.text.toString(),
                //         //       ),
                //         discountEnd: DateTime(
                //           _endDate.year,
                //           _endDate.month,
                //           _endDate.day,
                //           _endTime.hour,
                //           _endTime.minute,
                //         ),
                //         discountStart: DateTime(
                //           _startDate.year,
                //           _startDate.month,
                //           _startDate.day,
                //           _startTime.hour,
                //           _startTime.minute,
                //         ),
                //         earnings: "0",
                //       ),
                //     );

                //     Get.offAll(const MyHomePage());
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEndDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Event's End Date",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectedDate != null) {
                    _endDate = selectedDate;
                  }
                });
              },
              child: Text(
                "Select",
                style: TextStyle(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          DateFormat(
            "yyyy-MM-dd",
          ).format(
            _endDate,
          ),
        ),
      ],
    );
  }

  Widget buildStartDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Event's Start Date",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectedDate != null) {
                    _startDate = selectedDate;
                  }
                });
              },
              child: Text(
                "Select",
                style: TextStyle(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          DateFormat(
            "yyyy-MM-dd",
          ).format(
            _startDate,
          ),
        ),
      ],
    );
  }

  Widget buildStartTimeFeild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Event's Start Time",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    _startTime = timeOfDay;
                  }
                });
              },
              child: Text(
                "Select",
                style: TextStyle(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          _startTime.format(context),
        ),
      ],
    );
  }

  Widget buildEndTimeFeild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Event's End Time",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    _endTime = timeOfDay;
                  }
                });
              },
              child: Text(
                "Select",
                style: TextStyle(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          _endTime.format(context),
        ),
      ],
    );
  }
}
