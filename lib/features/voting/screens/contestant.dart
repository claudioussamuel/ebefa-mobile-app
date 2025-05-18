import 'package:ebefa/const/controller.dart';
import 'package:ebefa/features/voting/models/contestant.dart';
import 'package:ebefa/features/voting/screens/post_contestant_screen.dart';
import 'package:ebefa/features/voting/screens/widgets/author_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/size.dart';
import '../../post/empty_event.dart';

class Contestant extends StatelessWidget {
  const Contestant({
    super.key,
    required this.title,
    required this.categories,
    required this.eventPrice,
  });
  final String title;
  final List<dynamic> categories;
  final String eventPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$title Contestants",
          style: Theme.of(
            context,
          ).textTheme.labelLarge,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => PostVotingScreen(
              categories: categories,
              eventName: title,
              eventPrice: eventPrice,
            )),
        tooltip: 'Add',
        shape: const CircleBorder(),
        child: const Icon(Iconsax.add),
      ),
      body: StreamBuilder(
        stream: voteController.getListOfContestant(
          name: title,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              if (snapshot.hasData) {
                final contestant = snapshot.data as Iterable<ContestantModel>;

                final groupedByCategory =
                    _groupContestantsByCategory(contestant.toList());
                return ListView.builder(
                    itemCount: groupedByCategory.length,
                    itemBuilder: (context, index) {
                      final category = groupedByCategory.keys.elementAt(index);
                      final contestantsInCategory =
                          groupedByCategory[category]!;
                      return ExpansionTile(
                        title: Text(category),
                        children: contestantsInCategory
                            .map(
                              (contestant) => Padding(
                                padding: const EdgeInsets.all(TSizes.xs),
                                child: ContestantCard(
                                  authorName: contestant.name ?? "",
                                  title: "${contestant.vote} Votes",
                                  imageProvider: NetworkImage(
                                    contestant.media?[0]["url"],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                      // return Padding(
                      //   padding: const EdgeInsets.all(TSizes.xs),
                      //   child: ContestantCard(
                      //     authorName: contestants.name ?? "",
                      //     title: contestants.vote ?? "0",
                      //     imageProvider: NetworkImage(
                      //       contestants.media?[0]["url"],
                      //     ),
                      //   ),
                      // );
                    });
              } else if (!snapshot.hasData) {
                return const MyCalendarScreen();
              } else {
                return const Center(child: CircularProgressIndicator());
              }

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Map<String, List<ContestantModel>> _groupContestantsByCategory(
      List<ContestantModel> contestants) {
    final Map<String, List<ContestantModel>> grouped = {};

    for (var contestant in contestants) {
      if (!grouped.containsKey(contestant.category)) {
        grouped[contestant.category!] = [];
      }
      grouped[contestant.category]?.add(contestant);
    }

    return grouped;
  }
}
