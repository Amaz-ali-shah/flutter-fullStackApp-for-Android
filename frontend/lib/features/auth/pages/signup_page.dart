import 'package:flutter/material.dart';
import 'package:frontend/cubit/auth_cubit.dart';
import 'package:frontend/features/auth/pages/login_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    //formKey.currentState!.validate();
    super.dispose();
  }

  void signUpUser() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      //will implement later
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthSignUp) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account created ! Login Now")),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up.",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name Field Cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.trim().contains("@")) {
                        return "Email Field is invalid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length <= 6) {
                        return "Password Field is invalid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: signUpUser,
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have an Account?',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
