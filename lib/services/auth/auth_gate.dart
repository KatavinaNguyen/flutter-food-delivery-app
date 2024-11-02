import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/pages/login_page.dart';
import 'package:food_delivery_app/pages/register_page.dart';
import 'package:food_delivery_app/pages/home_page.dart';

class AuthGate extends StatefulWidget {
  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is signed in
          final email = snapshot.data?.email ?? '';
          return HomePage(email: email); // Pass email here
        } else {
          // User is not signed in
          return _buildAuthSelection();
        }
      },
    );
  }

  Widget _buildAuthSelection() {
    return Navigator(
      pages: [
        MaterialPage(child: LoginPage(onTap: _showRegisterPage)),
        if (_isRegisterPageVisible)
          MaterialPage(child: RegisterPage(onTap: _showLoginPage)),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  bool _isRegisterPageVisible = false;

  void _showRegisterPage() {
    setState(() {
      _isRegisterPageVisible = true;
    });
  }

  void _showLoginPage() {
    setState(() {
      _isRegisterPageVisible = false;
    });
  }
}
