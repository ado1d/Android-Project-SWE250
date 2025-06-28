import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:validators/validators.dart';
import 'package:page_transition/page_transition.dart';

import '../services/auth_service.dart';
import 'homepage.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String? _error;
  bool isEmailValid = false;

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final message = await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (message != null) {
        setState(() => _error = message);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
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
          //   image: AssetImage('assets/gojoBackground.jpg'),
          //   fit: BoxFit.cover,
          //   opacity: 0.4,
          // ),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xff1B262C),
              Color(0xff0F4C75),
              Color(0xff3282B8),
              Color(0xffBBE1FA),
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
                  Lottie.asset('assets/signupAnimation.json', height: 85),
                  Text(
                    'Create Account',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFFB8E7E2),
                      ),
                    ),
                  ),
                  Text(
                    'Sign up to continue',
                    style: GoogleFonts.stalinistOne(
                      textStyle: TextStyle(
                        color: Color(0xFFB8E7E2),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(0x5D67775B),
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
                            validator: (val) => isEmail(val ?? '') ? null : 'Enter a valid email',
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
                            validator: (value) {
                              if (value == null || value.length < 5) {
                                return 'Password must be at least 5 characters';
                              }
                              return null;
                            },
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
                                fontStyle: FontStyle.italic,
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
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: isEmailValid ? _signup : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                              backgroundColor: Color(0xFF31EB10),
                              disabledBackgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.stalinistOne(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.stalinistOne(textStyle: TextStyle(color: Colors.greenAccent, fontSize: 10)),
                      ),
                      // ElevatedButton(
                      //   onPressed: () => Navigator.pushReplacement(
                      //     context,
                      //     PageTransition(
                      //       type: PageTransitionType.leftToRightWithFade,
                      //       child: const LoginPage(),
                      //     ),
                      //     // MaterialPageRoute(builder: (_) => const LoginPage()),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0x308fd8a6),
                      //     shadowColor: Colors.transparent,
                      //
                      //   ),
                      //   child: Text(
                      //     'Log In',
                      //     style: TextStyle(color: Color(0xff352234), fontWeight: FontWeight.w800, fontSize: 16),
                      //   ),
                      // )
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              PageTransition(type: PageTransitionType.leftToRightWithFade, child: const LoginPage())
                              // MaterialPageRoute(builder: (_) => const SignupPage()),
                              );
                        },
                        child: Text(
                          'Log In',
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
