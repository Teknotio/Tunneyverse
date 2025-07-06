import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/signup_otp.dart'; // <-- Add this line!
import 'package:http/http.dart' as http;   // <-- Added for HTTP requests
import 'dart:convert'; 

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                  _SignUpHeaderRow(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 40 : 24),
                  Center(
                    child: Container(
                      width: mainWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 0 : 20,
                        vertical: isDesktop ? 0 : 64,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _SignUpForm(isDesktop: isDesktop),
                          SizedBox(height: isDesktop ? 24 : 18),
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
                          _TermsAndPrivacyText(),
                          SizedBox(height: 16),
                          _LoginPrompt(isDesktop: isDesktop),
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

class _SignUpHeaderRow extends StatelessWidget {
  final bool isDesktop;
  const _SignUpHeaderRow({required this.isDesktop});

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
                // Title
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: 508,
                    child: Text(
                      'Sign up',
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
                // Subtext
                Positioned(
                  left: 0,
                  top: 77,
                  child: SizedBox(
                    width: 508,
                    child: Opacity(
                      opacity: 0.75,
                      child: Text(
                        'Let’s get you all set up so you can access your personal account.',
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
      // Mobile layout, stacked arrow + title + subtext
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
              'Sign up',
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
                'Let’s get you all set up so you can access your personal account.',
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

class _SignUpForm extends StatefulWidget {
  final bool isDesktop;
  const _SignUpForm({required this.isDesktop});
  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Validate
    if (name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = "All fields are required!";
        isLoading = false;
      });
      return;
    }
    if (password != confirmPassword) {
      setState(() {
        errorMessage = "Passwords do not match!";
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.tuneyverse.com/users/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "full_name": name,
          "password": password,
          "role": "user",
          "username": username,
        }),
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success! Move to OTP
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OtpVerifyPage()),
        );
      } else {
        setState(() {
          // Try to extract backend error message
          String message = 'Registration failed!';
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
        errorMessage = "Network error. Please try again!";
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
        // Name
        Text(
          'Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Name',
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
        // Username
        Text(
          'Username',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: 'Username',
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

        // Email
        Text(
          'Email address',
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
            hintText: 'Email address',
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

        // Password
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
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
            ),
          ),
        ),
        SizedBox(height: 20),

        // Confirm Password
        Text(
          'Confirm Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: confirmPasswordController,
          obscureText: obscureConfirmPassword,
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
              icon: Icon(
                obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () =>
                  setState(() => obscureConfirmPassword = !obscureConfirmPassword),
            ),
          ),
        ),
        SizedBox(height: isDesktop ? 24 : 16),

        // Error message
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),

        // Loading indicator
        if (isLoading)
          Center(child: CircularProgressIndicator()),

        // SIGN UP BUTTON
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _handleSignUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF40367B),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 16 : 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFF251F48),
                ),
              ),
              elevation: 0,
            ),
            child: Text(
              'SIGN UP',
              style: TextStyle(
                letterSpacing: 1.5,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 20,
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
              fontSize: isDesktop ? 14 : 14,
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

class _TermsAndPrivacyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'By continuing, I agree to the',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: ' and ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: '.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  final bool isDesktop;
  const _LoginPrompt({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignInPage()),
          );
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: const Color(0xFF303030),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  color: const Color(0xFF50449A),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
