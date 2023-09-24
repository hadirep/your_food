import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_food/common/styles.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String routeName = 'reset_password_page';

  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(),
            const SizedBox(height: 24.0),
            Image.asset('assets/your_food.png', color: secondaryColor),
            const SizedBox(height: 24),
            Text(
              'Reset your password',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 12),
            MaterialButton(
              color: secondaryColor,
              textTheme: ButtonTextTheme.primary,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final email = _emailController.text;
                  await _auth.sendPasswordResetEmail(email: email);

                  _showSnackbar('Password reset email has been sent. Please check your inbox');
                } catch (e) {
                  _showSnackbar('An error occurred while sending the password reset email: $e');
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    final snackbar = SnackBar(content: Text(message));
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
