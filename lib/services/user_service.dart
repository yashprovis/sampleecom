import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/constants.dart';
import 'package:sampleecom/screens/tabs.dart';
import 'package:http/http.dart' as http;
import 'package:sampleecom/models/user_model.dart' as user;
import '../helpers/methods.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final CollectionReference _ref =
  //     FirebaseFirestore.instance.collection("users");

  Future<user.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    http.Response response =
        await http.get(Uri.parse("$baseUrl/user/${currentUser.uid}"));
    print(response.body);
    return user.User.fromSnap(jsonDecode(response.body)['data']);
  }

  Future loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        HelperMethods.showSnack(
            context: context, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        HelperMethods.showSnack(
            context: context,
            message: 'Wrong password provided for that user.');
      } else {
        HelperMethods.showSnack(context: context, message: e.message ?? "");
      }
    } catch (e) {
      HelperMethods.showSnack(context: context, message: e.toString());
    }
  }

  Future createUser(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.User currentUser = user.User(
          favourites: [],
          image: "",
          name: name,
          uid: credential.user!.uid,
          email: email,
          phone: phone);
      await http.post(
          headers: headerApiMap,
          body: jsonEncode(currentUser.toJson()),
          Uri.parse("$baseUrl/user"));
      //  await _ref.doc(credential.user!.uid).set(currentUser.toJson());
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        HelperMethods.showSnack(
            context: context, message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        HelperMethods.showSnack(
            context: context,
            message: 'The account already exists for that email.');
      } else {
        HelperMethods.showSnack(context: context, message: e.message ?? "");
      }
    } catch (e) {
      HelperMethods.showSnack(context: context, message: e.toString());
    }
  }

  Future forgotPassEmail(
      {required String email, required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      await _auth.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop();
      HelperMethods.showSnack(
          context: context,
          message: 'Reset Password link sent on Email.',
          color: Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        HelperMethods.showSnack(
            context: context, message: 'Please enter valid email.');
      } else {
        HelperMethods.showSnack(context: context, message: e.message ?? "");
      }
    } catch (e) {
      HelperMethods.showSnack(context: context, message: e.toString());
    }
  }

  Future<String?> changePassword(
      {required String currentPassword,
      required String newPassword,
      required BuildContext context}) async {
    final user = _auth.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);
    FocusScope.of(context).unfocus();
    try {
      await user.reauthenticateWithCredential(cred);
      try {
        await user.updatePassword(newPassword);
        Navigator.of(context).pop();
        HelperMethods.showSnack(
            context: context,
            message: 'Password Changed Successfully.',
            color: Colors.green);
      } on FirebaseAuthException catch (e) {
        return e.toString();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        return 'Invalid Password';
      } else {
        return e.toString();
      }
    }
    return null;
  }

  Future updateUserProfile(
      {String? name,
      String? phone,
      String? image,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      Map body = {};
      if (name != null) {
        body["name"] = name;
      }
      if (phone != null) {
        body["phone"] = phone;
      }
      if (image != null) {
        body["image"] = image;
      }
      await http.post(
          body: jsonEncode(body),
          headers: headerApiMap,
          Uri.parse("$baseUrl/updateUser/${_auth.currentUser!.uid}"));
      // await _ref
      //     .doc(_auth.currentUser!.uid)
      //     .update({"name": name, "phone": phone, "image": image});
      HelperMethods.showSnack(
          context: context,
          message: 'Profile Updated Successfully.',
          color: Colors.green);
    } on FirebaseException catch (e) {
      HelperMethods.showSnack(context: context, message: e.toString());
    }
  }

  Future alterFavService({required String productId}) async {
    Map body = {"uid": _auth.currentUser!.uid, "productId": productId};
    await http.post(
        body: jsonEncode(body),
        headers: headerApiMap,
        Uri.parse("$baseUrl/alterFav"));
  }
}
