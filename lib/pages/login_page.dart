import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:validators/validators.dart';

import '../services/auth_service.dart';
import 'signup_page.dart';
import 'homepage.dart';
import 'mainpage.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String? _error;
  bool isEmailValid = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final message = await _authService.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (message != null) {
        setState(() => _error = message);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/kakashiBackground.jpg'),
          //   fit: BoxFit.cover,
          //   opacity: 0.4,
          // ),

          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff4C0027),
              Color(0xff570530),
              Color(0xff570530),
              Color(0xff750550),
              Color(0xff980F5A),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loginAnimation.json', height: 85),
                  Text(
                    'Welcome back!',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFFB8E7E2),
                      ),
                    ),
                  ),
                  Text(
                    'Please login',
                    style: GoogleFonts.stalinistOne(
                      textStyle: TextStyle(
                        color: Color(0xFFB8E7E2),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: BoxDecoration(
                      color: Color(0x6486E4CE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_error != null)
                            Text(
                              _error!,
                              style: GoogleFonts.stalinistOne(
                                textStyle: TextStyle(color: Color(0xfff40632)),
                              ),
                            ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            onChanged: (val) {
                              setState(() {
                                isEmailValid = isEmail(val.trim());
                              });
                            },

                            style: GoogleFonts.indieFlower(
                                textStyle: TextStyle(
                              color: Color(0xFFFCFCFC),
                              fontWeight: FontWeight.w800,
                            )),
                            cursorColor: Color(0xFF31EB10),

                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email, color: Color(0xFF31EB10)),
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              filled: true,
                              fillColor: Color(0x5DF4F8F1),
                              labelStyle: GoogleFonts.stalinistOne(
                                textStyle: TextStyle(
                                  color: Color(0xFF31EB10),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),

                              // Change hint style
                              hintStyle: TextStyle(
                                color: Color(0xFF31EB10),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF31EB10), width: 2),
                              ),
                            ),
                            // style: GoogleFonts.poppins(fontSize: 13),
                            validator: (val) => isEmail(val ?? '') ? null : 'Enter a valid email',
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: GoogleFonts.indieFlower(
                                textStyle: TextStyle(
                              color: Color(0xFFFCFCFC),
                              fontWeight: FontWeight.w800,
                            )),
                            cursorColor: Color(0xfff40632),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock, color: Color(0xfff40632)),
                              labelText: 'Password',
                              hintText: 'Enter password',
                              filled: true,
                              fillColor: Color(0x5DF4F8F1),
                              labelStyle: GoogleFonts.stalinistOne(
                                textStyle: TextStyle(
                                  color: Color(0xfff40632),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xfff40632),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                fontStyle: FontStyle.italic, // Optional
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xfff40632), width: 2),
                              ),
                            ),
                            validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: isEmailValid ? _login : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                              backgroundColor: Color(0xFF06F07F),
                              disabledBackgroundColor: Colors.grey.withOpacity(0.6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Log In',
                                style:
                                    GoogleFonts.stalinistOne(textStyle: TextStyle(fontSize: 13, color: Colors.white))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style:
                              GoogleFonts.stalinistOne(textStyle: TextStyle(color: Colors.greenAccent, fontSize: 10))),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              PageTransition(type: PageTransitionType.rightToLeftWithFade, child: const SignupPage())
                              // MaterialPageRoute(builder: (_) => const SignupPage()),
                              );
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.teko(
                              textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.tealAccent,
                            decorationThickness: 3,
                            color: Colors.tealAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "CryptoPulse",
                        style: GoogleFonts.stalinistOne(
                          textStyle: const TextStyle(
                            color: Color(0xFFB8E7E2),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
