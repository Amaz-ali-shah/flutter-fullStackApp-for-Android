import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/auth_cubit.dart';
import 'package:frontend/features/auth/pages/signup_page.dart';
import 'package:frontend/features/home/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    formKey.currentState!.validate();
    super.dispose();
  }

  void loginUser() {
    if (formKey.currentState!.validate()) {
      //will implement later

      context.read<AuthCubit>().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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
          } else if (state is AuthUserLoggedIn) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text("You are Logged in!")),
            // );

            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (_) => false,
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
                    "Login.",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
                    onPressed: loginUser,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(SignupPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have  an Account?',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
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
