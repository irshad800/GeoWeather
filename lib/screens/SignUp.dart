import 'package:flutter/material.dart';

import '../auth_services.dart';
import '../utils/constants.dart';
import '../widgets/Custom_textfeild.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _ContactState();
}

class _ContactState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _CpasswordController = TextEditingController();

  final AuthServices _SignUpFB = AuthServices();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColors,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              top: 105,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Welcome Text

                              Text(
                                "Lets create Account Toghether",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[500],
                                    fontFamily: "Airbnb"),
                              ),

                              SizedBox(height: 30),

                              // Email Address
                              CustomTextField(
                                labeltext: 'Your Name',
                                controller: _usernameController,
                              ),

                              SizedBox(height: 20),

                              // Password
                              CustomTextField(
                                labeltext: 'Email Adress',
                                controller: _emailController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                labeltext: 'Password',
                                controller: _passwordController,
                                isPassword: true,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                labeltext: 'Confirm Password',
                                isPassword: true,
                                controller: _CpasswordController,
                              ),

                              SizedBox(height: 20),

                              // Sign In Button
                              ElevatedButton(
                                onPressed: () {
                                  print(_emailController.text);
                                  _SignUpFB.registration(
                                      password: _passwordController.text,
                                      cPassword: _CpasswordController.text,
                                      context: context,
                                      username: _usernameController.text,
                                      email: _emailController.text);
                                  print(_emailController);
                                  if (_formkey.currentState?.validate() ??
                                      false) {}
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColors,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                child: Text('Sign In',
                                    style: TextStyle(color: Colors.white)),
                              ),

                              SizedBox(height: 10),

                              // Sign In with Google Button
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide.none,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                icon: Image.asset('assets/images/img_4.png',
                                    height: 24),
                                label: Text(
                                  'Sign in with Google',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 90,
              child: Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Airbnb",
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
