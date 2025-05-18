import 'package:ebefa/features/voting/models/voting.dart';
import 'package:ebefa/features/voting/screens/widgets/single_card.dart';
import 'package:ebefa/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../const/controller.dart';
import '../../../const/firebase.dart';
import '../../../screens/terms_and_condition/terms_and_condition.dart';
import '../../post/empty_event.dart';
import 'add_new_vote_event.dart';
import 'contestant.dart';

class VotingHome extends StatelessWidget {
  const VotingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewVotingEventScreen()),
        tooltip: 'Add',
        shape: const CircleBorder(),
        child: const Icon(Iconsax.add),
      ),
      body: StreamBuilder(
          stream: voteController.getListOfVoting(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                if (snapshot.hasData) {
                  final voting = snapshot.data as Iterable<VotingModel>;
                  return ListView.builder(
                      itemCount: voting.length,
                      padding:
                          const EdgeInsets.symmetric(horizontal: TSizes.xs),
                      itemBuilder: (context, index) {
                        VotingModel votes = voting.elementAt(index);
                        return InkWell(
                          onTap: () {
                            Get.to(() => Contestant(
                                  title: votes.name ?? "",
                                  categories: votes.categories ?? [],
                                  eventPrice: votes.price ?? "0",
                                ));
                          },
                          child: Column(
                            children: [
                              TSingleAddress(
                                name: votes.name ?? '',
                                nmthree:
                                    "Voting Ends on ${DateFormat('MMMM d, y').format(votes.date ?? DateTime.now())}",
                                nmtwo: "Each vote is GH₵ ${votes.price}",
                                imageProvider:
                                    NetworkImage(votes.media?[0]["url"]),
                              ),
                            ],
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
    );
  }
}
