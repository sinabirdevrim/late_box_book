import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;

  Future<String> uploadFile(
      String userID, String fileType, File uploadFile) async {
    _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("profil_foto.png");
    var uploadTask = _storageReference.putFile(uploadFile);

    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    return url;
  }
}
