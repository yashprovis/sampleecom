import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/constants.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/sheets/change_password_sheet.dart';
import 'package:sampleecom/widgets/sheets/image_picker_sheet.dart';

import '../provider/user_provider.dart';
import '../widgets/ecom_text.dart';
import '../widgets/ecom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/editProfile";
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> editProfileFormKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    nameController.text = userProvider.getUser.name;
    emailController.text = userProvider.getUser.email;
    phoneController.text = userProvider.getUser.phone;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back_ios_new_rounded)),
                      const SizedBox(width: 12),
                      const EcomText(
                        "Edit Profile",
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Form(
                        key: editProfileFormKey,
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              imagePickerSheet(context);
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              margin:
                                  const EdgeInsets.only(bottom: 40, top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFF080808),
                                  borderRadius: BorderRadius.circular(60),
                                  image: userProvider.getUser.image == ""
                                      ? null
                                      : DecorationImage(
                                          image: NetworkImage(
                                              userProvider.getUser.image))),
                              child: userProvider.getUser.image == ""
                                  ? EcomText(
                                      userProvider.getUser.name
                                          .substring(0, 2)
                                          .toUpperCase(),
                                      color: Colors.white,
                                      size: 26)
                                  : null,
                            ),
                          ),
                          EcomTextField(
                            controller: nameController,
                            hintText: "Name *".toUpperCase(),
                            isPassword: false,
                            action: TextInputAction.next,
                            node: nameNode,
                            nextNode: phoneNode,
                          ),
                          const SizedBox(height: 20),
                          EcomTextField(
                            controller: phoneController,
                            hintText: "Phone Number *".toUpperCase(),
                            isPassword: false,
                            action: TextInputAction.next,
                            node: phoneNode,
                            nextNode: emailNode,
                          ),
                          const SizedBox(height: 20),
                          EcomTextField(
                            controller: emailController,
                            hintText: "Email *".toUpperCase(),
                            isPassword: false,
                            node: emailNode,
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 70),
                          Card(
                            elevation: 4,
                            child: EcomButton(
                                text: "Change Password",
                                func: () {
                                  changePasswordSheet(context);
                                },
                                color: Colors.white,
                                textColor: primaryColor,
                                isLoading: false),
                          ),
                          const SizedBox(height: 16),
                          Card(
                              elevation: 4,
                              child: EcomButton(
                                  text: "Save Changes",
                                  func: () {
                                    userProvider.updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        image: "",
                                        context: context);
                                  },
                                  isLoading: false))
                        ])))
              ]),
            )));
  }
}
