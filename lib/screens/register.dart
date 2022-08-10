import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/constants.dart';
import 'package:sampleecom/screens/home.dart';
import 'package:sampleecom/screens/login.dart';
import 'package:sampleecom/screens/tabs.dart';
import 'package:sampleecom/services/user_service.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/ecom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> registerFormKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  bool isLoading = false;

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              padding: const EdgeInsets.only(bottom: 20, top: 30),
              child: Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Hero(
                              tag: "logo-shift",
                              child: Image.asset("assets/images/logo.png")),
                          const SizedBox(height: 10),
                          const EcomText(
                            "CREATE ACCOUNT",
                            color: Colors.white,
                            size: 20,
                            weight: FontWeight.w300,
                          )
                        ],
                      )),
                  const Positioned(
                      right: 20,
                      top: 20,
                      child: const EcomText(
                        "SKIP",
                        size: 14,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            // ListView(
            //   shrinkWrap: true,
            //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            //   children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: registerFormKey,
                child: Column(
                  children: [
                    EcomTextField(
                      controller: nameController,
                      hintText: "Name *".toUpperCase(),
                      isPassword: false,
                      action: TextInputAction.next,
                      node: nameNode,
                      nextNode: phoneNode,
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: phoneController,
                      hintText: "Phone Number *".toUpperCase(),
                      isPassword: false,
                      action: TextInputAction.next,
                      node: phoneNode,
                      nextNode: emailNode,
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: emailController,
                      hintText: "Email *".toUpperCase(),
                      isPassword: false,
                      action: TextInputAction.next,
                      node: emailNode,
                      nextNode: passwordNode,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: passwordController,
                      hintText: "Password *".toUpperCase(),
                      isPassword: true,
                      node: passwordNode,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 26),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: isChecked,
                            fillColor: MaterialStateProperty.all(Colors.black),
                            onChanged: (value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                          // RichText(
                          //     text: TextSpan(
                          //         text: "Please accept  ",
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.w300,
                          //             fontSize: 14),
                          //         children: <TextSpan>[
                          //       TextSpan(
                          //         recognizer: TapGestureRecognizer()
                          //           ..onTap = () {
                          //             Navigator.of(context)
                          //                 .pushReplacementNamed(
                          //                     LoginScreen.routeName);
                          //           },
                          //         text: 'Terms & Conditions',
                          //         style: const TextStyle(
                          //             fontWeight: FontWeight.w400,
                          //             decoration: TextDecoration.underline,
                          //             color: primaryColor,
                          //             fontSize: 14),
                          //       ),
                          //     ])),
                          const Flexible(
                            child: EcomText(
                              "Please add me to the PUMA mailing list",
                              weight: FontWeight.w300,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    EcomButton(
                        isLoading: isLoading,
                        text: "REGISTER",
                        func: () {
                          if (registerFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              UserService().createUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  context: context);
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 80, color: Colors.grey, height: 1),
                          const EcomText(
                            "   OR   ",
                            size: 14,
                          ),
                          Container(width: 80, color: Colors.grey, height: 1)
                        ],
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                        label: const EcomText("SIGN IN"))
                  ],
                ),
              ),
            )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
