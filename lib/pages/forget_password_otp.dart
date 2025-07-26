import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/new_password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





class OtpVerificationPage extends StatelessWidget {
  final String email;
  final otpController = TextEditingController(); // Create here
  OtpVerificationPage({required this.email, super.key});

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
              // HEADER at the top, fixed
              SignUpHeader(isDesktop: isDesktop),

              // Spacer after header
              SizedBox(height: isDesktop ? 48 : 24),

              // Scrollable content
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _OtpHeader(isDesktop: isDesktop),
                        SizedBox(height: isDesktop ? 40 : 24),
                        Container(
                          width: mainWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 0 : 20,
                            vertical: isDesktop ? 0 : 40,
                          ),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _OtpForm(isDesktop: isDesktop, email: email, otpController: otpController), // <-- Updated here
                              SizedBox(height: 20),
                              _ResendRow(isDesktop: isDesktop, email: email), // <-- updated!
                              SizedBox(height: isDesktop ? 32 : 18),
                              _VerifyButton(
                                isDesktop: isDesktop,
                                email: email,
                                otpController: otpController,
                              ), // <-- Updated here
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

// --- Reuse your header component ---
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

class _OtpHeader extends StatelessWidget {
  final bool isDesktop;
  const _OtpHeader({required this.isDesktop});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 508,
      child: Column(
        children: [
          Text(
            'Verify code',
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
              'An authentication code has been sent to your email.',
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

class _OtpForm extends StatefulWidget {
  final bool isDesktop;
  final String email;
  final TextEditingController otpController;
  const _OtpForm({required this.isDesktop, required this.email, required this.otpController});
  @override
  State<_OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<_OtpForm> {

  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Code',
          style: TextStyle(
            color: const Color(0xFF1C1B1F),
            fontSize: isDesktop ? 16 : 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: widget.otpController, // ✅ correct controller
          keyboardType: TextInputType.text,
          maxLength: 6,
          decoration: InputDecoration(
            hintText: 'Enter Code',
            hintStyle: TextStyle(
              color: const Color(0xFF303030).withOpacity(0.4),
              fontSize: isDesktop ? 16 : 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            counterText: '',
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
      ],
    );
  }
}

class _ResendRow extends StatelessWidget {
  final bool isDesktop;
  final String email;

  const _ResendRow({required this.isDesktop, required this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Didn't receive a code?",
                style: TextStyle(
                  color: const Color(0xFF303030),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      final response = await http.post(
                        Uri.parse('https://api.tuneyverse.com/auth/resend-otp'),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'email': email,
                          'otp_type': 'password_reset', // or 'signup'
                        }),
                      );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("A new code has been sent to your email.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to resend code. Please try again.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred. Please try again.")),
    );
  }
},
                  child: Text(
                    ' Resend',
                    style: TextStyle(
                      color: const Color(0xFFFF8682),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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
}


class _VerifyButton extends StatelessWidget {
  final bool isDesktop;
  final String email;
  final TextEditingController otpController;
  const _VerifyButton({required this.isDesktop, required this.email, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
  final code = otpController.text.trim();

  if (code.length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter a valid 6-digit code.")),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('https://api.tuneyverse.com/auth/verify-reset-code'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code, 'email': email}),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NewPasswordPage(email: email, code: code),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid code. Please try again.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong. Please try again.")),
    );
  }
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
        child: Text(
          'VERIFY',
          style: TextStyle(
            letterSpacing: 1.5,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}


