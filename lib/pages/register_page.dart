import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/auth/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Focus nodes for text fields
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  // Error messages
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  // AuthService instance
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Add listeners to text fields
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    // Clean up controllers and listeners
    emailController.removeListener(_validateEmail);
    passwordController.removeListener(_validatePassword);
    confirmPasswordController.removeListener(_validatePasswords);
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

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

  void _validatePassword() {
    setState(() {
      passwordError = _isValidPassword(passwordController.text)
          ? ''
          : 'Please enter a strong password.';
    });
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _validatePasswords() {
    setState(() {
      confirmPasswordError =
          passwordController.text == confirmPasswordController.text
              ? ''
              : 'Passwords do not match.';
    });
  }

  void register() async {
    setState(() {
      emailError =
          emailController.text.isEmpty || !_isValidEmail(emailController.text)
              ? 'Please enter a valid email address.'
              : '';
      passwordError = passwordController.text.isEmpty ||
              !_isValidPassword(passwordController.text)
          ? 'Please enter a strong password.'
          : '';
      confirmPasswordError = confirmPasswordController.text.isEmpty ||
              confirmPasswordController.text != passwordController.text
          ? 'Passwords do not match.'
          : '';
    });

    // Check if all fields are valid before attempting registration
    if (emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      // Check if email is already in use
      bool emailInUse =
          await _authService.isEmailAlreadyInUse(emailController.text);
      if (emailInUse) {
        _showErrorDialog(
          "Email Already Registered",
          "This email address is already registered. Please use a different email.",
        );
        return;
      }

      // Perform registration logic
      try {
        var userCredential = await _authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );

        // Create a new customer entry in Firestore
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(userCredential.user?.uid)
            .set({
          'email': emailController.text,
          // Add any other customer details here
        });

        // Registration successful, navigate to next screen or show success message
        Navigator.of(context).pop(); // Navigate back or to a new screen
      } catch (e) {
        _showErrorDialog(
          "Registration Failed",
          "An error occurred while creating your account. Please try again.",
        );
      }
    } else {
      // Scroll to the first error field
      _scrollToFirstErrorField();
    }
  }

  // Show error dialog
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

  // Show password criteria dialog
  void _showPasswordCriteriaDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Password Criteria"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("- Password must have 8 or more characters."),
            Text("- The first character must be an uppercase letter."),
            Text("- Password must contain at least one number."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Scroll to the first error field
  void _scrollToFirstErrorField() {
    if (emailError.isNotEmpty) {
      FocusScope.of(context).requestFocus(emailFocusNode);
    } else if (passwordError.isNotEmpty) {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    } else if (confirmPasswordError.isNotEmpty) {
      FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/logo/Yum_Yum_Logo.PNG',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 25),
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  focusNode: emailFocusNode,
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
                const SizedBox(height: 10),
                Stack(
                  children: [
                    MyTextField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      hintText: "Password",
                      obscureText: true,
                    ),
                    Positioned(
                      right: 10,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: _showPasswordCriteriaDialog,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: const Text(
                            "!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (passwordError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        passwordError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                if (confirmPasswordError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        confirmPasswordError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                MyButton(
                  text: "Sign Up",
                  onTap: register,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: widget.onTap,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 87, 89, 90),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
