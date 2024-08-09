import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newtokteck_task/modules/auth/login_screen.dart';

import '../../modules/user/screens/user_dashboard_screen.dart';
import '../utils/helpers.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      String? role = await getUserRole(user!);

      if (role != null) {
        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin');
        } else {
          Navigator.pushReplacementNamed(context, '/user');
        }

        showCustomSnackBar(context: context, message: "Login Succesfull");
        print("Sign In Successful");
        return user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to retrieve user role"),
        ));
        return null;
      }
    } catch (e) {
      showCustomSnackBar(
          message: "Incorrect email or Password", context: context);
      return null;
    }
  }

  Future<User?> registration({
    required String email,
    required String password,
    required String cPassword,
    required BuildContext context,
    required String? username,
    required String role,
  }) async {
    if (password != cPassword) {
      showCustomSnackBar(message: "Password Donot Match", context: context);

      return null;
    }

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db.collection('users').doc(result.user?.uid).set({
        'email': email,
        'role': role,
      });

      showCustomSnackBar(
          message: "Account Created Succesfully", context: context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? ""),
          backgroundColor: Colors.red.withOpacity(0.9),
        ),
      );
      return null;
    } catch (e) {
      showCustomSnackBar(message: "Sign In Failed", context: context);

      return null;
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        final GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken,
        );

        await _auth.signInWithCredential(credential);
        print("Google Sign In Successful");
        showCustomSnackBar(
            message: "Google Sign In Successful", context: context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDashboardScreen()),
        );
      } else {
        showCustomSnackBar(
            message: "Google Sign In was aborted", context: context);

        print("Google Sign In was aborted");
      }
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: e.message ?? "Authentication error", context: context);

      print("FirebaseAuthException: ${e.message}");
    } catch (e) {
      showCustomSnackBar(message: "Something Went Wrong", context: context);

      print("General Exception: $e");
    }
  }

  Future<void> signOut({
    required BuildContext context,
  }) async {
    await _auth.signOut();
    showCustomSnackBar(message: "Logout Succesfully", context: context);
  }

  Future<String?> getUserRole(User user) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      return doc['role'] as String?;
    } catch (e) {
      print("Error fetching user role: $e");
      return null;
    }
  }

  String? getCurrentUserEmail() {
    User? user = _auth.currentUser;
    return user?.email;
  }
}
