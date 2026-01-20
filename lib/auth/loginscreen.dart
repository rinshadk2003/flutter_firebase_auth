import 'package:flutter/material.dart';
import 'package:loginorregister/auth/registerscreen.dart';
import 'package:provider/provider.dart';

import '../home/homescreen.dart';
import '../providers/authprovider.dart';
import '../widgets/CustomTextfield.dart';
import '../widgets/costumbutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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

              CoTextField(hintText: 'Email', controller: emailController),

              const SizedBox(height: 20),

              CoTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text("Forgot password?")],
              ),

              const SizedBox(height: 20),

              MyButton(
                text: authProvider.isLoading ? 'Logging in...' : 'Login',
                onTap: authProvider.isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;

                        try {
                          final userCredential = await context
                              .read<AuthProvider>()
                              .signInWithEmail(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

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
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
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
