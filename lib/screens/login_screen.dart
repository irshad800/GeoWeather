import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_services.dart';
import '../utils/constants.dart';
import '../widgets/Custom_textfeild.dart';
import 'SignUp.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  String? emailError;
  String? passwordError;
  bool loading = false;
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    double height = MediaQuery.of(context).size.height;
    print(height);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xFFF8F9FA),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Logo

                    SizedBox(height: 60),

                    // Welcome Text
                    Text(
                      'Hello Again!',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: primaryColors,
                          fontFamily: "Airbnb"),
                    ),
                    Text(
                      "Welcome Back You've Been Missed!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 40),

                    // Email Address
                    CustomTextField(
                      labeltext: 'Email Address',
                      controller: _emailController,
                    ),

                    SizedBox(height: 20),

                    // Password
                    CustomTextField(
                      labeltext: "Password",
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    // Recovery Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Recovery Password',
                          style: TextStyle(color: Color(0xFF707B81)),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Sign In Button
                    ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        User? user = await authService.signIn(
                            email: email, password: password, context: context);
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/');
                        } else {}
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

                    ElevatedButton.icon(
                      onPressed: () {
                        authService.signInWithGoogle(context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide.none,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      icon: Image.asset('assets/images/google.png', height: 24),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    SizedBox(
                      height: 170,
                    ),
                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have An Account?",
                          style: TextStyle(color: Color(0xFF707B81)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                          },
                          child: Text('Sign Up For Free',
                              style: TextStyle(color: primaryColors)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
