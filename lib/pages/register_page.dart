import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  Future<void> register(BuildContext context) async {
    final _auth = AuthService();

    if (passwordController.text == confirmPasswordController.text) {
      try {
        await _auth.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully registered!"),
          backgroundColor: Colors.green,
        ),
      );

        
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Password Don't match!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),
            Text(
              "Let's create an account for you",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 25),
            MyTextfield(
              hintText: "Email",
              obsecureText: false,
              controller: emailController,
            ),
            SizedBox(height: 10),
            MyTextfield(
              hintText: "Password",
              obsecureText: true,
              controller: passwordController,
            ),
            SizedBox(height: 10),
            MyTextfield(
              hintText: "Confirm Password",
              obsecureText: true,
              controller: confirmPasswordController,
            ),
            SizedBox(height: 25),
            MyButton(text: "Register", onTap: () => register(context)),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
