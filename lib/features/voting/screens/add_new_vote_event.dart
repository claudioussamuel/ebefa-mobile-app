import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ebefa/utils/constants/size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../const/controller.dart';
import '../../../models/event_media_model.dart';

class AddNewVotingEventScreen extends StatefulWidget {
  const AddNewVotingEventScreen({super.key});

  @override
  State<AddNewVotingEventScreen> createState() =>
      _AddNewVotingEventScreenState();
}

class _AddNewVotingEventScreenState extends State<AddNewVotingEventScreen> {
  void mediaDialog(BuildContext context) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select Media Type"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    imageDialog(context, true);
                  },
                  icon: const Icon(Icons.image),
                ),
                // IconButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //       imageDialog(context, false);
                //     },
                //     icon: const Icon(Icons.slow_motion_video_outlined)),
              ],
            ),
          );
        },
        context: context);
  }

  void imageDialog(BuildContext context, bool image) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Media Source"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.gallery);
                      } else {
                        getVideoDialog(ImageSource.gallery);
                      }
                    },
                    icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.camera);
                      } else {
                        getVideoDialog(ImageSource.camera);
                      }
                    },
                    icon: const Icon(Icons.camera_alt)),
              ],
            ),
          );
        },
        context: context);
  }

  getImageDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: source,
    );

    if (image != null) {
      voteController.votingMedia.add(EventMediaModel(
          image: File(image.path), video: null, isVideo: false));
    }

    setState(() {});
    Navigator.pop(context);
  }

  getVideoDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? video = await _picker.pickVideo(
      source: source,
    );

    if (video != null) {
      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: video.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );

      voteController.votingMedia.add(EventMediaModel(
          thumbnail: uint8list!, video: File(video.path), isVideo: true));
    }

    setState(() {});

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Awards Detials",
          style: Theme.of(
            context,
          ).textTheme.titleLarge,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          voteController.submit();
        },
        tooltip: 'Add',
        shape: const CircleBorder(),
        child: const Icon(Iconsax.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 500,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D3D3),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: DottedBorder(
                    color: const Color(0xFF808080),
                    strokeWidth: 1.5,
                    dashPattern: const [6, 6],
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: 76,
                              height: 59,
                              child: Icon(
                                Icons
                                    .add_a_photo, // You can use any icon you prefer
                                size: 70,
                                color: Color(0xFF00755E),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                mediaDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00755E),
                              ),
                              child: const Text("Upload"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                voteController.votingMedia.isEmpty
                    ? Container()
                    : const SizedBox(
                        height: 20,
                      ),
                voteController.votingMedia.isEmpty
                    ? Container()
                    : SizedBox(
                        width: 500,
                        height: 100,
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return voteController.votingMedia[i].isVideo!
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                      right: 15,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(
                                            voteController
                                                .votingMedia[i].thumbnail!,
                                          ),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    const Color(0xFF00755E),
                                                child: IconButton(
                                                  onPressed: () {
                                                    voteController.votingMedia
                                                        .removeAt(i);

                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.slow_motion_video_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.only(
                                        right: 15, bottom: 10, top: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                            voteController
                                                .votingMedia[i].image!,
                                          ),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CircleAvatar(
                                            child: IconButton(
                                              onPressed: () {
                                                voteController.votingMedia
                                                    .removeAt(i);

                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.close),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                          },
                          itemCount: voteController.votingMedia.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: voteController.name,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "Awards Name"),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TextFormField(
                  controller: voteController.price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.dollar_circle),
                    labelText: "Price of Each Vote",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                buildEndDateField(context),
                // ==== Dynammic Category Form Field =====
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: voteController.listController.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, TSizes.spaceBtwItems, 0, 0),
                      child: TextFormField(
                        controller: voteController.listController[index],
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.card),
                          labelText: "Category ${index + 1}",
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                //======== On Pressed Button =======
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        voteController.listController
                            .add(TextEditingController());
                      });
                    },
                    child: const Text("Add Catergory"),
                  ),
                ),
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
          children: [
            const Icon(Iconsax.calendar),
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
                    voteController.date.value = selectedDate;
                  }
                });
              },
              child: Text(
                "Select End Date For Voting",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        Text(
          DateFormat(
            "yyyy-MM-dd",
          ).format(
            voteController.date.value,
          ),
        ),
      ],
    );
  }
}
