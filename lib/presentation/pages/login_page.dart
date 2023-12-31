import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/presentation/pages/register_page.dart';
import 'package:your_food/presentation/pages/reset_password_page.dart';
import 'package:your_food/presentation/pages/restaurant_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
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
            Image.asset('assets/your_food.png', color: secondaryColor),
            const SizedBox(height: 24.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                hintText: 'Password',
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
                  final navigator = Navigator.of(context);
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  navigator.pushReplacementNamed(RestaurantListPage.routeName);
                } catch (e) {
                  if (e is FirebaseAuthException && e.code == 'wrong-password') {
                    _showErrorSnackbar('The password you entered is incorrect');
                  } else {
                    _showErrorSnackbar('The email or password you entered is incorrect');
                  }
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              child: const Text(
                'Does not have an account yet? Register here',
                style: TextStyle(color: secondaryColor),
              ),
              onPressed: () => Navigator.pushNamed(context, RegisterPage.routeName),
            ),
            TextButton(
              child: const Text(
                'Forgot your password? Click here',
                style: TextStyle(color: secondaryColor),
              ),
              onPressed: () => Navigator.pushNamed(context, ResetPasswordPage.routeName),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    final snackbar = SnackBar(content: Text(errorMessage));
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
