import 'package:flutter/material.dart';

class OtpVerifyPage extends StatelessWidget {
  const OtpVerifyPage({super.key});

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

              // Spacer if you want space after header
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
                              _OtpForm(isDesktop: isDesktop),
                              SizedBox(height: 20),
                              _ResendRow(isDesktop: isDesktop),
                              SizedBox(height: isDesktop ? 32 : 18),
                              _VerifyButton(isDesktop: isDesktop),
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
    return Container(
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
  const _OtpForm({required this.isDesktop});
  @override
  State<_OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<_OtpForm> {
  final _otpController = TextEditingController();

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
          controller: _otpController,
          keyboardType: TextInputType.number,
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
  const _ResendRow({required this.isDesktop});
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
                  onTap: () {
                    // TODO: Add resend logic here
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
  const _VerifyButton({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Add verify logic here
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

// For testing/demo:
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Demo',
      debugShowCheckedModeBanner: false,
      home: OtpVerifyPage(),
    );
  }
}
