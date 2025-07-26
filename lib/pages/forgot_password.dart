import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/forget_password_otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          final mainWidth = isDesktop ? 512.0 : 347.0;

          return Column(
            children: [
              // Header at the top
              SignUpHeader(isDesktop: isDesktop),
              SizedBox(height: isDesktop ? 48 : 24),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _ForgotHeader(isDesktop: isDesktop),
                        SizedBox(height: isDesktop ? 40 : 24),
                        Container(
                          width: mainWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 0 : 20,
                            vertical: isDesktop ? 0 : 40,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ForgotForm(isDesktop: isDesktop), // <-- Updated here
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: isDesktop ? 32 : 20),
            ],
          );
        },
      ),
    );
  }
}

// --- Reuse your header ---
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

class _ForgotHeader extends StatelessWidget {
  final bool isDesktop;
  const _ForgotHeader({required this.isDesktop});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 508,
      child: Column(
        children: [
          Text(
            'Forgot your password?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF303030),
              fontSize: isDesktop ? 40 : 28,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Opacity(
            opacity: 0.75,
            child: Text(
              'Don’t worry, happens to all of us. Enter your email below to recover your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF303030),
                fontSize: isDesktop ? 16 : 14,
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

// ---------- UPDATED FORM -----------
class ForgotForm extends StatefulWidget {
  final bool isDesktop;
  const ForgotForm({required this.isDesktop});
  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final _emailController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final email = _emailController.text.trim();

    // Replace with your API endpoint for sending OTP
    final url = Uri.parse('https://api.tuneyverse.com/auth/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'otp_type': 'password_reset'}),
      );

      if (response.statusCode == 200) {
        // Go to OTP page, pass the email along
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpVerificationPage(email: email),
          ),
        );
      } else {
        final msg = json.decode(response.body)['message'] ?? 'Error sending OTP. Please try again.';
        setState(() {
          _error = msg;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Network error. Please check your connection.";
      });
    } finally {
      setState(() {
        _loading = false;
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
          'Email address',
          style: TextStyle(
            color: const Color(0xFF6A6A6A),
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(
              color: const Color(0xFF1C1B1F),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Color(0xFF79747E),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
          ),
          style: TextStyle(
            color: const Color(0xFF303030),
            fontSize: isDesktop ? 16 : 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20),
        if (_error != null)
          Text(_error!, style: TextStyle(color: Colors.red, fontSize: 14)),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _loading
                ? null
                : () {
                    if (_emailController.text.trim().isEmpty) {
                      setState(() {
                        _error = 'Please enter your email address.';
                      });
                      return;
                    }
                    _submit(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF40367B),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 16 : 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFF251F48),
                ),
              ),
              elevation: 0,
            ),
            child: _loading
                ? const SizedBox(
                    width: 24, height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Text(
                    'SUBMIT',
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
