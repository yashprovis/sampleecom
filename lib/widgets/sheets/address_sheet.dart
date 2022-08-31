import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/helpers/methods.dart';

import '../../models/address_model.dart';
import '../../provider/user_provider.dart';
import '../../services/address_service.dart';

import '../ecom_button.dart';
import '../ecom_text.dart';
import '../ecom_text_field.dart';

void addressSheet(BuildContext context, Address? address) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return AddressSheet(address: address);
      });
}

class AddressSheet extends StatefulWidget {
  final Address? address;
  const AddressSheet({Key? key, this.address}) : super(key: key);

  @override
  State<AddressSheet> createState() => _AddressSheetState();
}

class _AddressSheetState extends State<AddressSheet> {
  GlobalKey<FormState> addressFormKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController line1Controller = TextEditingController();
  TextEditingController line2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode line1Node = FocusNode();
  FocusNode line2Node = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode stateNode = FocusNode();
  FocusNode pincodeNode = FocusNode();

  double height = 500;
  bool isLoading = false;

  @override
  void initState() {
    if (widget.address != null) {
      nameController.text = widget.address!.name;
      line1Controller.text = widget.address!.line1;
      line2Controller.text = widget.address!.line2;
      cityController.text = widget.address!.city;
      stateController.text = widget.address!.state;
      pincodeController.text = widget.address!.pincode;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(14),
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Form(
            key: addressFormKey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: EcomText(
                            "${widget.address == null ? "Add" : "Update"} Address",
                            size: 18,
                            weight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(height: 20),
                    EcomTextField(
                      controller: nameController,
                      hintText: "Name *".toUpperCase(),
                      isPassword: false,
                      action: TextInputAction.next,
                      node: nameNode,
                      nextNode: line1Node,
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: line1Controller,
                      hintText: "Address Line 1 *".toUpperCase(),
                      isPassword: false,
                      action: TextInputAction.next,
                      node: line1Node,
                      nextNode: line2Node,
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: line2Controller,
                      hintText: "Address Line 2 *".toUpperCase(),
                      isPassword: false,
                      action: TextInputAction.next,
                      node: line2Node,
                      nextNode: cityNode,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
                          child: EcomTextField(
                            controller: cityController,
                            hintText: "City *".toUpperCase(),
                            isPassword: false,
                            action: TextInputAction.next,
                            node: cityNode,
                            nextNode: pincodeNode,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
                          child: EcomTextField(
                            controller: pincodeController,
                            hintText: "Pincode *".toUpperCase(),
                            isPassword: false,
                            node: pincodeNode,
                            nextNode: stateNode,
                            action: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: stateController,
                      hintText: "State *".toUpperCase(),
                      isPassword: false,
                      node: stateNode,
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 6,
                      child: EcomButton(
                          height: 44,
                          isLoading: isLoading,
                          text:
                              "${widget.address == null ? "Add" : "Update"} Address",
                          textSize: 16,
                          func: () async {
                            if (addressFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                if (widget.address == null) {
                                  Address address = Address(
                                      name: nameController.text.trim(),
                                      line1: line1Controller.text.trim(),
                                      line2: line2Controller.text.trim(),
                                      city: cityController.text.trim(),
                                      state: stateController.text.trim(),
                                      pincode: pincodeController.text.trim());
                                  Map<String, dynamic> fireAddress =
                                      await AddressService()
                                          .addAddressService(address: address);
                                  await userProvider.addAddress(
                                      address: Address.fromSnap(fireAddress));
                                } else {
                                  Address updateAddress = Address(
                                      id: widget.address!.id,
                                      name: nameController.text.trim(),
                                      line1: line1Controller.text.trim(),
                                      line2: line2Controller.text.trim(),
                                      city: cityController.text.trim(),
                                      state: stateController.text.trim(),
                                      pincode: pincodeController.text.trim());
                                  await userProvider.updateAddress(
                                      address: updateAddress);
                                }
                                Navigator.of(context).pop();
                                HelperMethods.showSnack(
                                    context: context,
                                    message:
                                        'Address ${widget.address == null ? "Added" : "Updated"} Successfully.',
                                    color: Colors.green);
                              } catch (e) {
                                Navigator.of(context).pop();
                                HelperMethods.showSnack(
                                    context: context,
                                    message:
                                        'An error occured. Please try again',
                                    color: Colors.red);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              setState(() {
                                height = 600;
                              });
                            }
                          }),
                    ),
                  ]),
            ),
          )),
    );
  }
}
