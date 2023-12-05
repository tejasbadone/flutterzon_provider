import 'package:amazon_clone_flutter/common/widgets/custom_textfield.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_elevated_button.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
    setState(() {
      isLoading = false;
    });
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: isLoading
          ? SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/amazon_in.png',
                        height: 40,
                        width: 50,
                      ),
                      const SizedBox.square(
                        dimension: 12,
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox.square(
                        dimension: 12,
                      ),

                      // Sign Up Section
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 10, right: 8, left: 8),
                        decoration: BoxDecoration(
                          color: _auth == Auth.signUp
                              ? GlobalVariables.backgroundColor
                              : GlobalVariables.greyBackgroundColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              minLeadingWidth: 2,
                              leading: SizedBox.square(
                                dimension: 12,
                                child: Radio(
                                    value: Auth.signUp,
                                    groupValue: _auth,
                                    onChanged: (Auth? val) {
                                      setState(() {
                                        _auth = val!;
                                      });
                                    }),
                              ),
                              title: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                    text: 'Create account. ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'New to Amazon?',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black87),
                                  )
                                ]),
                              ),
                              onTap: () {
                                setState(() {
                                  _auth = Auth.signUp;
                                });
                              },
                            ),
                            if (_auth == Auth.signUp)
                              Form(
                                key: _signUpFormKey,
                                child: Column(
                                  children: [
                                    CustomTextfield(
                                      controller: _nameController,
                                      hintText: 'First and last name',
                                    ),
                                    CustomTextfield(
                                      controller: _emailController,
                                      hintText: 'Email',
                                    ),
                                    CustomTextfield(
                                      controller: _passwordController,
                                      hintText: 'Set password',
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/info_icon.png',
                                          height: 15,
                                          width: 15,
                                        ),
                                        const Text(
                                            '  Passwords must be at least 6 characters.'),
                                      ],
                                    ),
                                    const SizedBox.square(
                                      dimension: 15,
                                    ),
                                    CustomElevatedButton(
                                      buttonText: 'Create account',
                                      onPressed: () {
                                        if (_signUpFormKey.currentState!
                                            .validate()) {
                                          isLoading = true;
                                          setState(() {});

                                          showSnackBar(context,
                                              'Signing Up, please wait...');

                                          signUpUser();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Sign In Section
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 10, right: 8, left: 8),
                        decoration: BoxDecoration(
                            color: _auth == Auth.signIn
                                ? GlobalVariables.backgroundColor
                                : GlobalVariables.greyBackgroundColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            ListTile(
                              minLeadingWidth: 2,
                              leading: SizedBox.square(
                                dimension: 12,
                                child: Radio(
                                    value: Auth.signIn,
                                    groupValue: _auth,
                                    onChanged: (Auth? val) {
                                      setState(() {
                                        _auth = val!;
                                      });
                                    }),
                              ),
                              title: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                    text: 'Sign in. ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Already a customer?',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black87),
                                  ),
                                ]),
                              ),
                              onTap: () {
                                setState(() {
                                  _auth = Auth.signIn;
                                });
                              },
                            ),
                            if (_auth == Auth.signIn)
                              Form(
                                key: _signInFormKey,
                                child: Column(
                                  children: [
                                    CustomTextfield(
                                        controller: _emailController,
                                        hintText: 'Email'),
                                    CustomTextfield(
                                        controller: _passwordController,
                                        hintText: 'Password'),
                                    const SizedBox.square(
                                      dimension: 6,
                                    ),
                                    CustomElevatedButton(
                                      buttonText: 'Continue',
                                      onPressed: () {
                                        if (_signInFormKey.currentState!
                                            .validate()) {
                                          isLoading = true;
                                          setState(() {});

                                          showSnackBar(context,
                                              'Signing In, please wait...');

                                          signInUser();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox.square(
                        dimension: 20,
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        indent: 20,
                        endIndent: 20,
                        thickness: 0.5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customTextButton(buttonText: 'Conditions of Use'),
                            customTextButton(buttonText: 'Privacy Notice'),
                            customTextButton(buttonText: 'Help'),
                          ]),
                      const Center(
                        child: Text(
                          '© 1996-2023, Amazon.com, Inc. or its affiliates',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox.square(
                        dimension: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  TextButton customTextButton({String? buttonText}) {
    return TextButton(
      onPressed: () {},
      child: Text(
        buttonText!,
        style: const TextStyle(color: Color(0xff1F72C5), fontSize: 15),
      ),
    );
  }
}
