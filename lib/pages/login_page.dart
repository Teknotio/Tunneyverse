import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/user_dashboard.dart';
import 'package:tuneyverse/pages/forgot_password.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:http/http.dart' as http;  // <-- ADDED
import 'dart:convert';                     // <-- ADDED



class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          final mainWidth = isDesktop ? 450.0 : 347.0;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SignUpHeader(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 48 : 24),
                  _SignInHeaderRow(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 40 : 24),
                  Center(
                    child: Container(
                      width: mainWidth,
                      padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 0 : 20,
                          vertical: isDesktop ? 0 : 64),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // FORM
                          SizedBox(
                            width: isDesktop ? double.infinity : 307,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SignInForm(isDesktop: isDesktop),
                                SizedBox(height: isDesktop ? 20 : 16),
                                _SignInDivider(isDesktop: isDesktop),
                                SizedBox(height: isDesktop ? 20 : 12),
                                _SocialButton(
                                  label: 'CONTINUE WITH APPLE',
                                  color: Colors.black.withAlpha(229),
                                  textColor: Colors.white,
                                  icon: Icons.apple,
                                  fontSize: isDesktop ? 13 : 8,
                                ),
                                SizedBox(height: 12),
                                _SocialButton(
                                  label: 'CONTINUE WITH GOOGLE',
                                  color: Colors.white,
                                  textColor: const Color(0xFF6A6A6A),
                                  icon: Icons.g_mobiledata,
                                  outlined: true,
                                  fontSize: isDesktop ? 13 : 8,
                                ),
                                SizedBox(height: isDesktop ? 32 : 18),
                                _SignUpPrompt(isDesktop: isDesktop), // <-- updated!
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isDesktop ? 32 : 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SignUpHeader extends StatelessWidget {
  final bool isDesktop;
  const SignUpHeader({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isDesktop ? 92 : 64,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFD9DADC),
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: isDesktop ? 38 : 28,
              width: isDesktop ? 38 : 28,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              'Tuneyverse',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF170F49),
                fontSize: 28.15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 1.06,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInHeaderRow extends StatelessWidget {
  final bool isDesktop;
  const _SignInHeaderRow({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 24, color: Colors.black),
            onPressed: () => Navigator.maybePop(context),
            tooltip: "Back",
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 508,
            height: 101,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: 508,
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF303030),
                        fontSize: 40,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 77,
                  child: SizedBox(
                    width: 508,
                    child: Opacity(
                      opacity: 0.75,
                      child: Text(
                        'Login to access your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF303030),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 24, color: Colors.black),
                onPressed: () => Navigator.maybePop(context),
                tooltip: "Back",
              ),
            ),
            Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF303030),
                fontSize: 28,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Opacity(
              opacity: 0.75,
              child: Text(
                'Login to access your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF303030),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _SignInForm extends StatefulWidget {
  final bool isDesktop;
  const _SignInForm({required this.isDesktop});
  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  bool rememberMe = false;
  bool obscurePassword = true;

  // <-- ADDED: Controllers and state
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;      // <-- ADDED
  String? errorMessage;

  @override
  void dispose() {            // <-- ADDED
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // <-- ADDED: Login logic
  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.tuneyverse.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      print("Status: ${response.statusCode}, Body: ${response.body}"); // for debugging

      if (response.statusCode == 200) {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomepageDashboard()),
          );
        } else {
        setState(() {
          String message = 'Login failed!';
          try {
            final resp = json.decode(response.body);
            if (resp is Map && resp['message'] != null) {
              message = resp['message'].toString();
            }
          } catch (_) {}
          errorMessage = message;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error. Please try again!';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email address or username',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email address or username',
            hintStyle: TextStyle(
              color: const Color(0xFF6A6A6A),
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: const Color(0xFF6A6A6A),
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (val) => setState(() => rememberMe = val ?? false),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  activeColor: const Color(0xFF5548A4),
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: isDesktop ? 13 : 8,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
        );
        // TODO: Add your password reset logic here!
        // Navigator.push(...); or showDialog(...);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerRight,
      ),
      child: Text(
        'Forgot your password?',
        style: TextStyle(
          color: Colors.black,
          fontSize: isDesktop ? 16 : 10,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
          ],
        ),
        SizedBox(height: isDesktop ? 18 : 14),
        // <-- ADDED: Error and loading state
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        if (isLoading)
          Center(child: CircularProgressIndicator()),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5548A4),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 14 : 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              elevation: 0,
            ),
            child: Text(
              'LOG IN',
              style: TextStyle(
                letterSpacing: 1.5,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SignInDivider extends StatelessWidget {
  final bool isDesktop;
  const _SignInDivider({this.isDesktop = true});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color(0xFFD9DADC),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 20 : 10),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: isDesktop ? 1.0 : 0.07,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color(0xFFD9DADC),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final IconData icon;
  final bool outlined;
  final double fontSize;

  const _SocialButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.icon,
    this.outlined = false,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          side: outlined
              ? BorderSide(color: const Color(0xFF878787), width: 1)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
        icon: Icon(icon, color: textColor, size: 24),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

// UPDATED: This button navigates to SignUpPage!
class _SignUpPrompt extends StatelessWidget {
  final bool isDesktop;
  const _SignUpPrompt({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignUpPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6A6A6A),
              side: const BorderSide(
                width: 1,
                color: Color(0xFF878787),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 16 : 10),
              backgroundColor: Colors.white,
            ),
            child: Text(
              'SIGN UP FOR TUNEYVERSE',
              style: TextStyle(
                color: const Color(0xFF6A6A6A),
                fontSize: isDesktop ? 13 : 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
