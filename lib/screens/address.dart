import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/sheets/address_sheet.dart';
import 'package:sampleecom/widgets/tiles/address_tile.dart';

import '../provider/user_provider.dart';
import '../widgets/ecom_text.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address";
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 15, right: 20),
            child: Column(children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                  const SizedBox(width: 12),
                  const EcomText(
                    "Address",
                    size: 18,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemCount: userProvider.getUser.address!.length,
                  itemBuilder: (context, index) {
                    return AddressTile(
                        address: userProvider.getUser.address![index]);
                  },
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: EcomButton(
                      text: "+ Add Address",
                      func: () {
                        addressSheet(context, null);
                      },
                      isLoading: false))
            ])));
  }
}
