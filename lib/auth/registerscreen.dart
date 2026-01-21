import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authprovider.dart';
import '../widgets/CustomTextfield.dart';
import '../widgets/costumbutton.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  void _register(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    if (authProvider.passwordController.text.trim() !=
        authProvider.confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    try {
      await authProvider.registerWithEmail();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration successful')));
      authProvider.clearControllers();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Spacer(),

              CoTextField(
                hintText: 'Name',
                controller: authProvider.nameController,
              ),

              const SizedBox(height: 20),

              CoTextField(
                hintText: 'Email',
                controller: authProvider.emailController,
              ),

              const SizedBox(height: 20),

              CoTextField(
                hintText: 'Password',
                controller: authProvider.passwordController,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              CoTextField(
                hintText: 'Confirm Password',
                controller: authProvider.confirmPasswordController,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              MyButton(
                onTap: authProvider.isLoading ? null : () => _register(context),
                child: authProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Register",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
