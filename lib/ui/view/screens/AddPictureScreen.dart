import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/provider/addPictureProvider.dart';
import 'package:instagram_clone/core/provider/userRepository.dart';
import 'package:instagram_clone/core/utils/statefulWrapper.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// Widget to capture and crop the image
class AddPictureScreen extends StatefulWidget {
  createState() => _AddPictureScreenState();
}

class _AddPictureScreenState extends State<AddPictureScreen> {
  final controllerLegend = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    return ChangeNotifierProvider(
      create: (_) => AddPictureProvider(userRepository.userId),
      child: Consumer(builder: (_, AddPictureProvider addPicture, __) {
        if (addPicture.isLoading) {
          return Scaffold();
        } else {
          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => addPicture.pickImage(ImageSource.gallery),
                    child: Text("GALERIE"),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  FlatButton(
                    onPressed: () => addPicture.pickImage(ImageSource.camera),
                    child: Text("PHOTO"),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  FlatButton(
                    onPressed: () => addPicture.pickImage(ImageSource.camera),
                    child: Text("VIDEO"),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ),

            // Preview the image and crop it
            body: ListView(
              children: <Widget>[
                if (addPicture.imageFile != null) ...[
                  Image.file(addPicture.imageFile),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.crop),
                        onPressed: addPicture.cropImage,
                      ),
                      if (addPicture.isOneOneImage) _sendImageToFirabase(),
                      FlatButton(
                        child: Icon(Icons.refresh),
                        onPressed: addPicture.clear,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextField(
                      controller: controllerLegend,
                      decoration:
                          InputDecoration(hintText: 'Ajouter une légende...'),
                    ),
                  ),
                ]
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _sendImageToFirabase() {
    return Consumer(
      builder: (_, AddPictureProvider addPicture, __) {
        if (addPicture.uploadTask != null) {
          return Column(
            children: [
              if (addPicture.uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: addPicture.uploadTask.resume,
                ),
              if (addPicture.uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: addPicture.uploadTask.pause,
                ),
              if (addPicture.uploadTask.isComplete)
                StatefulWrapper(
                  child: Icon(Icons.check),
                  onInit: () => {
                    Future.delayed(
                      Duration.zero,
                      () => Toast.show("Image ajoutée", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM),
                    ),
                  },
                ),
            ],
          );
        } else {
          return IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: addPicture.startUpload,
          );
        }
      },
    );
  }
}
