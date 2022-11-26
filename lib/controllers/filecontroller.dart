import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:get/state_manager.dart';

class FileController extends GetxController {
  Future uploadfile(File file) async {
    String url;
    final storageRef = FirebaseStorage.instance.ref();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    Reference mountainsRef = storageRef.child("$time.jpg");
    TaskSnapshot task =
        await mountainsRef.putFile(file).whenComplete(() => null);
    url = await mountainsRef.getDownloadURL();
    return url;
  }
}
