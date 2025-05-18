import 'package:flutter/material.dart';
import 'package:ebefa/models/tickect.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../const/controller.dart';
import '../payment/withdrawal_screen.dart';

class Attendance extends StatefulWidget {
  const Attendance({
    super.key,
    required this.tickectModel,
  });

  final TickectModel tickectModel;

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String result = 'ebefa';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Attendance',
            style: Theme.of(
              context,
            ).textTheme.displaySmall,
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                //

                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));

                for (var user in widget.tickectModel.users!) {
                  if (user is Map<String, dynamic>) {
                    if (user.containsKey("id") &&
                        user["id"] == '$res' &&
                        user.containsKey("hasAttended") &&
                        user["hasAttended"] == false) {
                      ticketController.verifyTickets(
                          widget.tickectModel, '$res');
                      break;
                    }
                    // else {
                    //   showFailure();
                    //   break;
                    // }
                  }
                }
              },
              icon: const Icon(
                Icons.qr_code_scanner,
                size: 30,
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(
              context,
            ).floatingActionButtonTheme.backgroundColor,
            tabs: [
              Tab(
                child: Text(
                  "Tickets Sold",
                  style: TextStyle(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Revenue",
                  style: TextStyle(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            buildAttendanceList(context, widget.tickectModel, result),
            EarningsScreen(
              tickectModel: widget.tickectModel,
            )
          ],
        ),
      ),
    );
  }

  Widget buildAttendanceList(
      BuildContext context, TickectModel tickectModel, String ticketId) {
    return StreamBuilder(
      stream: ticketController.allTickets(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            if (tickectModel.users != null) {
              final attendess = tickectModel.users;
              return ListView.builder(
                  itemCount: attendess!.length,
                  itemBuilder: (context, index) {
                    var ticket = attendess[index];

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .floatingActionButtonTheme
                              .backgroundColor,
                          child: Text(
                            "${ticket["ticketprice"]}",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        title: Text("${ticket["id"]}"),
                        trailing: Icon(
                          ticket["hasAttended"] ? Icons.check : null,
                          color: ticket["hasAttended"]
                              ? Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor
                              : Colors.green,
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.pink));
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.black));
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
