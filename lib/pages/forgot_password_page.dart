import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/auth/auth_services.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService();
  String emailError = '';

  void _validateEmail() {
    setState(() {
      emailError = _isValidEmail(emailController.text)
          ? ''
          : 'Please enter a valid email address.';
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _resetPassword() async {
    _validateEmail();
    if (emailError.isEmpty) {
      try {
        await _authService.sendPasswordResetEmail(emailController.text);
        _showSuccessDialog();
      } catch (e) {
        _showErrorDialog(
            "Error", "Failed to send password reset email. Please try again.");
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: const Text("A password reset email has been sent."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              if (emailError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    emailError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              MyButton(
                text: "Reset Password",
                onTap: _resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
