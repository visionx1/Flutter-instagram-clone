import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  Future uploadImage(BuildContext context) async {
    var _image = await ImagePicker().getImage(source: ImageSource.gallery);
    File imageFile = File(_image.path);
    final userId = FirebaseAuth.instance.currentUser.uid;
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('Stories/' + DateTime.now().toIso8601String());

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot =
        await uploadTask.onComplete.whenComplete(() {
      Flushbar(
        duration: Duration(seconds: 3),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutCirc,
        flushbarStyle: FlushbarStyle.GROUNDED,
        padding: EdgeInsets.all(10.0),
        message: 'Successfully Uploaded',
      )..show(context);
    });
    uploadTask.events.listen((event) {}).onError((error) {
      Flushbar(
        duration: Duration(seconds: 3),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutCirc,
        flushbarStyle: FlushbarStyle.GROUNDED,
        padding: EdgeInsets.all(10.0),
        message: 'An error occurred ',
      )..show(context);
    });

    taskSnapshot.ref.getDownloadURL().then((photoUrl) async {
      print(photoUrl);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("Stories")
          .add({
        "userId": userId,
        "createdDate": DateTime.now(),
        "storyLink": photoUrl,
      });
    }).catchError((error) {
      Flushbar(
        duration: Duration(seconds: 3),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutCirc,
        flushbarStyle: FlushbarStyle.GROUNDED,
        padding: EdgeInsets.all(10.0),
        message: error.toString(),
      )..show(context);
    });
  }

  // Future deleteImage(String uid) {
  //   return
  // }

}
