import 'package:flutter/material.dart';
import 'package:loginorregister/auth/registerscreen.dart';
import 'package:provider/provider.dart';

import '../home/homescreen.dart';
import '../providers/authprovider.dart';
import '../widgets/CustomTextfield.dart';
import '../widgets/costumbutton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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
                hintText: 'Email',
                controller: authProvider.emailController,
              ),

              const SizedBox(height: 20),

              CoTextField(
                hintText: 'Password',
                controller: authProvider.passwordController,
                obscureText: true,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text("Forgot password?")],
              ),

              const SizedBox(height: 20),

              MyButton(
                onTap: authProvider.isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        try {
                          final userCredential = await context
                              .read<AuthProvider>()
                              .signInWithEmail();
                          if (userCredential != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Homescreen(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login successful')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                child: authProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Login",
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
                    'Don’t have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Register',
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
