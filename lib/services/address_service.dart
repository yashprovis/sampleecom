//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampleecom/models/address_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class AddressService {
  // final CollectionReference _ref = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection("address");

  Future<Map<String, dynamic>> addAddressService(
      {required Address address}) async {
    // final docRef = _ref.doc();

    // addressJson["id"] = docRef.id;
    // await docRef.set(addressJson);
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(address.toJson()),
        Uri.parse(
            "$baseUrl/address/${FirebaseAuth.instance.currentUser!.uid}"));

    List data = jsonDecode(response.body)['data']["address"];

    return data[data.length - 1];
  }

  Future removeAddressService({required String id}) async {
    await http.delete(headers: headerApiMap, Uri.parse("$baseUrl/address/$id"));
  }

  Future updateAddressService({required Address address}) async {
    await http.put(
        headers: headerApiMap,
        body: jsonEncode(address.toJson()),
        Uri.parse("$baseUrl/address/${address.id}"));
  }
}
