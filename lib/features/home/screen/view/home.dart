import 'package:ebefa/features/post/empty_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ebefa/models/tickect.dart';
import '../../../post/screens/main_post.dart';
import '../widget/appointment_preview_card.dart';
import '../../../../const/controller.dart';
import '../../../../const/firebase.dart';
import '../../../../screens/attendence/attendance.dart';
import '../../../../screens/terms_and_condition/terms_and_condition.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "EBEFA",
            style: Theme.of(
              context,
            ).textTheme.displaySmall,
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: ticketController.allTickets(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  if (snapshot.hasData) {
                    final tickets = snapshot.data as Iterable<TickectModel>;
                    return ListView.builder(
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          TickectModel ticket = tickets.elementAt(index);
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Attendance(
                                    tickectModel: ticket,
                                  ),
                                ),
                              );
                            },
                            child: EventCard(
                              image: ticket.media?[0]["url"],
                              payed: ticket.typeTickets![0]["price"] != null
                                  ? "Paid"
                                  : "Free",
                              date: DateFormat('MMMM d, y')
                                  .format(ticket.enddate!),
                              city: ticket.city!,
                              title: ticket.name!,
                              location: ticket.location!,
                            ),
                          );
                        });
                  } else if (!snapshot.hasData) {
                    return const MyCalendarScreen();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const PostScreen(),
              ),
            );
          },
          tooltip: 'Add',
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Obx(() => UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).floatingActionButtonTheme.backgroundColor,
                  ),
                  accountName: Text(
                    authController.adminModel.value.name ?? "",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium,
                  ),
                  accountEmail: Text(
                    authController.adminModel.value.email ?? "",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall,
                  ))),
              ListTile(
                onTap: () {
                  Get.to(() => const TermsAndConditions());
                },
                leading: const Icon(Icons.article_outlined),
                title: const Text("Terms And Conditions"),
              ),
              ListTile(
                onTap: () {
                  auth.signOut();
                },
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Log out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
