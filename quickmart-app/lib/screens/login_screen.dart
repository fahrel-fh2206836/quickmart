import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quickmart/widget/frosted_glass.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 204, 244, 213),
              Color.fromARGB(255, 116, 247, 120),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset(
                  "assets/images/quickmart_text.png",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FrostedGlassBox(
                      boxWidth: double.infinity,
                      boxHeight: MediaQuery.of(context).size.height * .5,
                      boxChild: buildLoginForm(context),
                      isCurved: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Enter your login information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 110, 7),
                  fontSize: 18),
            ),
          ),
          const SizedBox(height: 30),
          FrostedGlassTextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            prefixIcon: const Icon(Icons.alternate_email_outlined,
                color: Color.fromARGB(255, 3, 110, 7)),
          ),
          const SizedBox(height: 30),
          FrostedGlassTextField(
            controller: _passwordController,
            obscureText: isVisible,
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock_outlined,
                color: Color.fromARGB(255, 3, 110, 7)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Icon(
                isVisible ? Icons.visibility_off : Icons.visibility,
                color: const Color.fromARGB(255, 3, 110, 7),
              ),
            ),
          ),
          const SizedBox(height: 30),
          LoginButton(
            onLoginPressed: () {},
          ),
          const SizedBox(height: 25),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Don\'t have an account?  ',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                TextSpan(
                  text: "Register",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 3, 110, 7),
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // context.pushNamed('register');
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const LoginButton({super.key, required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onLoginPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 3, 110, 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
