import 'package:flutter/material.dart';

class CustomerSection extends StatelessWidget {
  const CustomerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Section'),
      ),
      body: Center(
        child: Text('Welcome to the Customer Section!'),
      ),
    );
  }
}
