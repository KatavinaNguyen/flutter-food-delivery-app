import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/models/customer.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unknown error occurred.');
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // After signing up, create a new customer record
      await _createCustomerRecord(userCredential.user!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unknown error occurred.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('An unknown error occurred.');
    }
  }

  // Check if email is already in use
  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      final result = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      print("Error checking if email is in use: $e");
      return false;
    }
  }

  // Check if email is registered
  Future<bool> isEmailRegistered(String email) async {
    try {
      final result = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException error: ${e.code}");
      return false;
    } catch (e) {
      print("Unknown error: $e");
      return false;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unknown error occurred.');
    }
  }

  // Get customer by ID
  Future<Customer?> getCustomerById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('customers').doc(id).get();
      if (doc.exists) {
        return Customer.fromFirestore(doc);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching customer by ID: $e");
      return null;
    }
  }

  // Create a new customer record after signup
  Future<void> _createCustomerRecord(User user) async {
    try {
      final customer = Customer(
        id: user.uid,
        email: user.email ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _firestore
          .collection('customers')
          .doc(user.uid)
          .set(customer.toMap());
    } catch (e) {
      print("Error creating customer record: $e");
    }
  }
}
