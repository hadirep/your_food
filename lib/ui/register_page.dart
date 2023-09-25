import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_food/common/styles.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = 'restaurant_register_page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;
  String? _registrationError; // Error message for registration

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
            Text(
              'Create your account',
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
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
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
            _registrationError != null
                ? Text(
              _registrationError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            )
                : Container(),
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
                  _registrationError = null; // Reset the registration error
                });
                try {
                  final navigator = Navigator.of(context);
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  // Validate email format
                  if (!isValidEmail(email)) {
                    _showErrorSnackbar('The email address format is not valid');
                    setState(() {
                      _isLoading = false;
                    });
                    return; // Don't proceed with registration
                  }

                  await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  navigator.pop();
                } catch (e) {
                  if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
                    _showErrorSnackbar('Your account has already been created');
                  } else {
                    _showErrorSnackbar('An error occurred while creating the account');
                  }
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: secondaryColor),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
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
