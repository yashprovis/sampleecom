import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/helpers/methods.dart';
import 'package:sampleecom/services/user_service.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../../constants.dart';
import '../../provider/user_provider.dart';

Future imagePickerSheet(BuildContext context) async {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        UserProvider userProvider = Provider.of<UserProvider>(context);
        return StatefulBuilder(builder: (context, ss) {
          return Container(
              padding: const EdgeInsets.all(16),
              height: 180,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const EcomText(
                        "Profile Picture",
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () async {
                                XFile file =
                                    await HelperMethods.getImageFromCamera();
                                File imageFile = File(file.path);
                                UserService()
                                    .updateUserProfilePicture(
                                        context: context, image: imageFile)
                                    .whenComplete(() {
                                  userProvider
                                      .updateUser(
                                          name: null,
                                          phone: null,
                                          image:
                                              "$uploadUrl/user/user--${userProvider.getUser.uid}",
                                          context: context)
                                      .whenComplete(
                                          () => Navigator.of(context).pop());
                                });
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(CupertinoIcons.camera))),
                          const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: EcomText(
                                "Camera",
                                size: 14,
                              ))
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              XFile file =
                                  await HelperMethods.getImageFromGallery();
                              File imageFile = File(file.path);
                              UserService()
                                  .updateUserProfilePicture(
                                      context: context, image: imageFile)
                                  .whenComplete(() {
                                userProvider
                                    .updateUser(
                                        name: null,
                                        phone: null,
                                        image:
                                            "$uploadUrl/user/user--${userProvider.getUser.uid}",
                                        context: context)
                                    .whenComplete(
                                        () => Navigator.of(context).pop());
                              });
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                width: 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                    CupertinoIcons.photo_on_rectangle)),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: EcomText(
                                "Gallery",
                                size: 14,
                              ))
                        ],
                      ),
                      const SizedBox(width: 30),
                      userProvider.getUser.image == ""
                          ? const SizedBox()
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    UserService()
                                        .updateUserProfile(
                                            context: context, image: "")
                                        .whenComplete(() {
                                      userProvider.refreshUser().whenComplete(
                                          () => Navigator.of(context).pop());
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      width: 60,
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        color: Colors.white,
                                      )),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: EcomText(
                                      "Remove",
                                      size: 14,
                                    ))
                              ],
                            ),
                    ],
                  ),
                ],
              ));
        });
      });
}
