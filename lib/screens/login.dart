import 'package:flutter/material.dart';
import 'package:sampleecom/constants.dart';
import 'package:sampleecom/screens/forgot_password.dart';
import 'package:sampleecom/screens/register.dart';
import 'package:sampleecom/screens/tabs.dart';
import 'package:sampleecom/services/user_service.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/ecom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool isLoading = false;

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
                  borderRadius: BorderRadius.only(
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
                              child: Image.asset("assets/images/logo.png",
                                  width: double.infinity, height: 240)),
                          const SizedBox(height: 5),
                          const EcomText(
                            "SIGN IN",
                            color: Colors.white,
                            size: 24,
                            weight: FontWeight.w300,
                          )
                        ],
                      )),
                  // Positioned(
                  //     right: 20,
                  //     top: 20,
                  //     child: GestureDetector(
                  //         onTap: () => Navigator.of(context)
                  //             .pushReplacementNamed(TabsScreen.routeName),
                  //         child: const EcomText(
                  //           "SKIP",
                  //           size: 14,
                  //           color: Colors.white,
                  //         )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: emailController,
                      hintText: "EMAIL *",
                      isPassword: false,
                      action: TextInputAction.next,
                      node: emailNode,
                      nextNode: passwordNode,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    EcomTextField(
                      controller: passwordController,
                      isPassword: true,
                      node: passwordNode,
                      hintText: "PASSWORD *",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.routeName);
                        },
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password?',
                                style: TextStyle(
                                    height: 1,
                                    fontWeight: FontWeight.w300,
                                    color: primaryColor,
                                    fontSize: 14))),
                      ),
                    ),
                    EcomButton(
                        isLoading: isLoading,
                        text: "SIGN IN",
                        func: () {
                          if (loginFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              UserService()
                                  .loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context)
                                  .whenComplete(() => setState(() {
                                        isLoading = false;
                                      }));
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
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routeName),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                          label: const EcomText("Create Account")),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
