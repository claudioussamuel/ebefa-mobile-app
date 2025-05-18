import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ebefa/utils/constants/size.dart';

import '../../../const/controller.dart';

class DateInfo extends StatefulWidget {
  const DateInfo({super.key});

  @override
  State<DateInfo> createState() => _DateInfoState();
}

class _DateInfoState extends State<DateInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Date",
          style: Theme.of(
            context,
          ).textTheme.titleLarge,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          buildStartDateField(context),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          buildEndDateField(context),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          buildStartTimeFeild(context),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          buildEndTimeFeild(context),
        ],
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
              style: Theme.of(context).textTheme.titleLarge,
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
                    ticketController.endDate.value = selectedDate;
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
            ticketController.endDate.value,
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
              style: Theme.of(context).textTheme.titleLarge,
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
                    ticketController.startDate.value = selectedDate;
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
            ticketController.startDate.value,
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    ticketController.startTime.value = timeOfDay;
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
          ticketController.startTime.value.format(context),
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    ticketController.endTime.value = timeOfDay;
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
          ticketController.endTime.value.format(context),
        ),
      ],
    );
  }
}
