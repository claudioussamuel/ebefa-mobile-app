import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ebefa/const/controller.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../models/event_media_model.dart';
import '../../utils/constants/size.dart';
import '../../utils/constants/text_string.dart';

class MakePost extends StatefulWidget {
  const MakePost({super.key});

  @override
  State<MakePost> createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Event Info",
            style: Theme.of(
              context,
            ).textTheme.titleLarge,
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    options: RectDottedBorderOptions(

                    color: const Color(0xFF808080),
                    strokeWidth: 1.5,
                    dashPattern: const [6, 6],
                    ) ,
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
                ticketController.media.isEmpty
                    ? Container()
                    : const SizedBox(
                        height: 20,
                      ),
                ticketController.media.isEmpty
                    ? Container()
                    : SizedBox(
                        width: 500,
                        height: 100,
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return ticketController.media[i].isVideo!
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
                                            ticketController
                                                .media[i].thumbnail!,
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
                                                    ticketController.media
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
                                            ticketController.media[i].image!,
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
                                                ticketController.media
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
                          itemCount: ticketController.media.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        expands: false,
                        controller: ticketController.eventName,
                        decoration: const InputDecoration(
                          labelText: TText.eventName,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TextFormField(
                        expands: false,
                        controller: ticketController.eventLocation,
                        decoration: const InputDecoration(
                          labelText: TText.eventLocation,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TextFormField(
                        expands: false,
                        controller: ticketController.eventCity,
                        decoration: const InputDecoration(
                          labelText: TText.eventCity,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TextFormField(
                        expands: false,
                        controller: ticketController.phoneNumber,
                        decoration: const InputDecoration(
                          labelText: TText.phoneNumber,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TextFormField(
                        expands: false,
                        maxLines: 5,
                        controller: ticketController.eventAbout,
                        decoration: const InputDecoration(
                          labelText: TText.eventAbout,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImageDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: source,
    );

    if (image != null) {
      ticketController.media.add(EventMediaModel(
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

      ticketController.media.add(EventMediaModel(
          thumbnail: uint8list!, video: File(video.path), isVideo: true));
    }

    setState(() {});

    Navigator.pop(context);
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
}
