import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/constants/appStrings.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;

class AddPictureProvider with ChangeNotifier {
  String _userId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  File _imageFile;
  File get imageFile => _imageFile;
  set imageFile(File imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }

  bool _isOneOneImage = false;
  bool get isOneOneImage => _isOneOneImage;
  set isOneOneImage(bool isOneOneImage) {
    _isOneOneImage = isOneOneImage;
    notifyListeners();
  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://instagram-clone-d854e.appspot.com');

  final databaseReference = FirebaseDatabase.instance.reference();

  StorageUploadTask _uploadTask;
  StorageUploadTask get uploadTask => _uploadTask;
  set uploadTask(StorageUploadTask uploadTask) {
    _uploadTask = uploadTask;
    notifyListeners();
  }

  AddPictureProvider(this._userId);

  Future<void> startUpload() async {
    String filePath = '$_userId/${Uuid().v1()}.png';
    final ref = _storage.ref().child(filePath);
    StorageUploadTask storageUploadTask = ref.putFile(_imageFile);
    uploadTask = storageUploadTask;
    String downloadLink =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    notifyListeners();
    _addPictureLinkToDatabase(downloadLink);
  }

  Future<void> _addPictureLinkToDatabase(downloadLink) async {
    const url = AppStrings.serverUrl + 'insertPicture';
    await http.post(
      Uri.encodeFull(url),
      body: jsonEncode({
        "uid": _userId,
        "url": downloadLink,
        "date": new DateTime.now().toString(),
        "legend": "legend"
      }),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
    );
    imageFile = cropped ?? _imageFile;
    print(await _checkIfIsOneOneImage(imageFile));
  }

  Future<void> pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    imageFile = selected;
    if (!await _checkIfIsOneOneImage(selected)) {
      cropImage();
    }
  }

  void clear() {
    imageFile = null;
    uploadTask = null;
  }

  Future<bool> _checkIfIsOneOneImage(img) async {
    var decodedImage = await decodeImageFromList(img.readAsBytesSync());
    if (decodedImage.width == decodedImage.height) {
      isOneOneImage = true;
      return true;
    }
    isOneOneImage = false;
    return false;
  }
}
