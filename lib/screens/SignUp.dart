import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_services.dart';
import '../utils/constants.dart';
import '../widgets/Custom_textfeild.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _cPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedRole = 'user'; // Default role

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Let's create an account together",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                                fontFamily: "Airbnb",
                              ),
                            ),
                            SizedBox(height: 30),
                            CustomTextField(
                              labeltext: 'Your Name',
                              controller: _usernameController,
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              labeltext: 'Email Address',
                              controller: _emailController,
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              labeltext: 'Password',
                              controller: _passwordController,
                              isPassword: true,
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              labeltext: 'Confirm Password',
                              isPassword: true,
                              controller: _cPasswordController,
                            ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: _selectedRole,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedRole = newValue!;
                                });
                              },
                              items: <String>[
                                'user',
                                'admin'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Select Role',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  User? user = await authService.registration(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    cPassword: _cPasswordController.text,
                                    context: context,
                                    username: _usernameController.text,
                                    role: _selectedRole, // Pass the role
                                  );
                                  if (user != null) {
                                    Navigator.pushReplacementNamed(
                                        context, '/');
                                  } else {
                                    // Handle signup error
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColors,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text('Sign Up',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            SizedBox(height: 10),
                          ],
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
