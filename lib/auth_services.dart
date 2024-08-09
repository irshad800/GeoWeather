import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newtokteck_task/screens/login_screen.dart';
import 'package:newtokteck_task/screens/user/user_dashboard_screen.dart';
import 'package:newtokteck_task/utils/constants.dart';

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

      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin');
      } else {
        Navigator.pushReplacementNamed(context, '/user');
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: primaryColors,
        content: Text("Login Successful"),
      ));
      print("Sign In Successful");
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColors,
          content: Text("Incorrect email or password"),
        ),
      );
      return null;
    }
  }

  Future<User?> registration({
    required String email,
    required String password,
    required String cPassword,
    required BuildContext context,
    required String? username,
    required String role, // Add role parameter
  }) async {
    if (password != cPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return null;
    }

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a user document in Firestore
      await _db.collection('users').doc(result.user?.uid).set({
        'email': email,
        'role': role,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account Created Successfully"),
          backgroundColor: primaryColors,
        ),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("SignUp Failed"),
          backgroundColor: primaryColors,
        ),
      );
      return null;
    }
  }

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColors,
            content: Text("Google Sign In Was Successful"),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.withOpacity(0.9),
            content: Text("Google Sign In was aborted"),
          ),
        );
        print("Google Sign In was aborted");
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.9),
          content: Text(e.message ?? "Authentication error"),
        ),
      );
      print("FirebaseAuthException: ${e.message}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.9),
          content: Text("Something went wrong"),
        ),
      );
      print("General Exception: $e");
    }
  }

  Future<void> signOut({
    required BuildContext context,
  }) async {
    await _auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed out'),
        backgroundColor: Colors.green,
      ),
    );
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
