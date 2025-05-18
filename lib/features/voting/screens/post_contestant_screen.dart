import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../const/controller.dart';
import '../../../models/event_media_model.dart';
import '../../../utils/constants/size.dart';

class PostVotingScreen extends StatefulWidget {
  const PostVotingScreen({
    super.key,
    required this.categories,
    required this.eventName,
    required this.eventPrice,
  });
  final List<dynamic> categories;
  final String eventName;
  final String eventPrice;

  @override
  State<PostVotingScreen> createState() => _PostVotingScreenState();
}

class _PostVotingScreenState extends State<PostVotingScreen> {
  void _showCategories() async {
    final String? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CategorySelect(categories: widget.categories);
        });

    if (results != null) {
      setState(() {
        voteController.category.value = results;
      });
    }
  }

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
          "Contestant Detials",
          style: Theme.of(
            context,
          ).textTheme.titleLarge,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          voteController.submitContestant(
            eventName: widget.eventName,
            eventPrice: widget.eventName,
            context: context,
          );
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
                  controller: voteController.contestantName,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Contestant Name",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TextFormField(
                  controller: voteController.votingCode,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.dollar_circle),
                    labelText: "Voting Code",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                Text(voteController.category.value),

                //======== On Pressed Button =======
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showCategories();
                    },
                    child: const Text("Add Category"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategorySelect extends StatefulWidget {
  const CategorySelect({
    super.key,
    required this.categories,
  });
  final List<dynamic> categories;

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  String selectedCatergory = '';

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, selectedCatergory);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Category'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.categories
              .map(
                (category) => RadioListTile<String>(
                  value: category,
                  groupValue: selectedCatergory,
                  onChanged: (value) {
                    setState(() {
                      selectedCatergory = value.toString();
                    });
                  },
                  title: Text(category),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(onPressed: _cancel, child: const Text("Cancel")),
        TextButton(onPressed: _submit, child: const Text("Submit"))
      ],
    );
  }
}
