import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/stateful_wrapper.dart';
import 'package:instagram_clone/utils/string.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;

/// Widget to capture and crop the image
class PickImageAndAddedToFirebase extends StatefulWidget {
  final String uid;

  PickImageAndAddedToFirebase({Key key, @required this.uid}) : super(key: key);

  createState() => _PickImageAndAddedToFirebaseState(uid: uid);
}

class _PickImageAndAddedToFirebaseState
    extends State<PickImageAndAddedToFirebase> {
  /// Active image file
  File _imageFile;
  bool isOneOneImage = false;
  final controllerLegend = TextEditingController();

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://instagram-clone-d854e.appspot.com');

  final databaseReference = FirebaseDatabase.instance.reference();

  StorageUploadTask _uploadTask;

  String uid;

  _PickImageAndAddedToFirebaseState({@required this.uid});

  Future<void> _startUpload() async {
    String filePath = '$uid/${Uuid().v1()}.png';
    final ref = _storage.ref().child(filePath);
    StorageUploadTask storageUploadTask = ref.putFile(_imageFile);

    setState(() {
      _uploadTask = storageUploadTask;
    });

    String downloadLink =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    _addPictureLinkToDatabase(downloadLink);
  }

  Future<void> _addPictureLinkToDatabase(downloadLink) async {
    const url = AppStrings.serverUrl + 'insertPicture';
    await http.post(
      Uri.encodeFull(url),
      body: jsonEncode({
        "uid": uid,
        "url": downloadLink,
        "date": new DateTime.now().toString(),
        "legend": controllerLegend.text.toString()
      }),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> _cropImage() async {
    var cropImage = ImageCropper.cropImage(sourcePath: _imageFile.path);
    File cropped = await cropImage;
    _checkIfIsOneOneImage(cropped);
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    _checkIfIsOneOneImage(selected);
    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() => {_imageFile = null, _uploadTask = null});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text("GALERIE"),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            FlatButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text("PHOTO"),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            FlatButton(
              onPressed: () => _pickImage(ImageSource.camera),
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
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                if (isOneOneImage) _sendImageToFirabase(),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                controller: controllerLegend,
                decoration: InputDecoration(hintText: 'Ajouter une légende...'),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Future<void> _checkIfIsOneOneImage(img) async {
    var decodedImage = await decodeImageFromList(img.readAsBytesSync());
    if (decodedImage.width == decodedImage.height) {
      setState(() {
        isOneOneImage = true;
      });
      return;
    }
    setState(() {
      isOneOneImage = false;
    });
    Toast.show("Veuillez rogner la photo dans le format 1:1", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    return;
  }

  Widget _sendImageToFirabase() {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (_, snapshot) {
          return Column(
            children: [
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              if (_uploadTask.isComplete)
                StatefulWrapper(
                  child: Icon(Icons.check),
                  onInit: () => {
                    Future.delayed(
                      Duration.zero,
                      () => Toast.show("Image ajoutée", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM),
                    ),
                    print(snapshot.toString())
                  },
                ),
            ],
          );
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
