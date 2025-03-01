import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //method to sign up user
  Future<Map<String, dynamic>?> userSignup({
    required String email,
    required String password,
    required String username,
    required String role, // Add role parameter
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,  // Store role in Firestore
      });

      return {"status": "Successful", "role": role};
    } catch (e) {
      return {"status": "Error", "message": e.toString()};
    }
  }

  //method to sign in user
  Future<Map<String, dynamic>?> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch role from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

      if (userDoc.exists) {
        String role = userDoc['role']; // Get role from Firestore
        return {"status": "Successful", "role": role};
      } else {
        return {"status": "Error", "message": "User data not found"};
      }
    } catch (e) {
      return {"status": "Error", "message": e.toString()};
    }
  }

  //method to sign out user
  Future<void> signOut() async{
    await _auth.signOut();
  }

}
