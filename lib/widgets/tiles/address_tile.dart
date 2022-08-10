import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/models/address_model.dart';
import 'package:sampleecom/widgets/sheets/address_sheet.dart';

import '../../provider/user_provider.dart';
import '../ecom_text.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  final bool? removable;
  final double? size;
  const AddressTile(
      {Key? key, required this.address, this.removable, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EcomText(address.name, size: size),
                  if (removable == null)
                    GestureDetector(
                      onTap: () {
                        userProvider.removeAddress(id: address.id!);
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              EcomText(
                  '${address.line1}, ${address.line2}, ${address.city}, ${address.state} - ${address.pincode}',
                  size: size ?? 15),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    addressSheet(context, address);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                    decoration: BoxDecoration(border: Border.all()),
                    child: EcomText("Edit", size: 14),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
