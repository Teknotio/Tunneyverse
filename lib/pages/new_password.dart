import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tuneyverse/pages/login_page.dart'; // <-- Replace with your path

class NewPasswordPage extends StatelessWidget {
  final String email;
  final String code;
  
  const NewPasswordPage({super.key, required this.email, required this.code});

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
              SignUpHeader(isDesktop: isDesktop),
              SizedBox(height: isDesktop ? 48 : 24),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _NewPasswordHeader(isDesktop: isDesktop),
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
                              _NewPasswordForm(
                                isDesktop: isDesktop,
                                email: email,
                                code: code,
                              ),
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

class _NewPasswordHeader extends StatelessWidget {
  final bool isDesktop;
  const _NewPasswordHeader({required this.isDesktop});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 508,
      child: Column(
        children: [
          Text(
            'Set a password',
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
              'Your previous password has been reseted. Please set a new password for your account.',
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

class _NewPasswordForm extends StatefulWidget {
  final bool isDesktop;
  final String email;
  final String code;
  const _NewPasswordForm({
    required this.isDesktop,
    required this.email,
    required this.code,
  });
  @override
  State<_NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<_NewPasswordForm> {
  bool obscurePassword = true;
  bool obscureConfirm = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;
    final passwordsMatch =
        passwordController.text == confirmController.text && passwordController.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create Password', style: TextStyle(
          color: const Color(0xFF303030),
          fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400,
        )),
        SizedBox(height: 8),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Enter Password ',
            hintStyle: TextStyle(
              color: const Color(0xFF1C1B1F).withOpacity(0.5),
              fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF79747E)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true, fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
            ),
          ),
          style: TextStyle(
            color: const Color(0xFF303030),
            fontSize: isDesktop ? 16 : 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 24),
        Text('Re-enter Password', style: TextStyle(
          color: const Color(0xFF303030),
          fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400,
        )),
        SizedBox(height: 8),
        TextField(
          controller: confirmController,
          obscureText: obscureConfirm,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Enter Password ',
            hintStyle: TextStyle(
              color: const Color(0xFF1C1B1F).withOpacity(0.5),
              fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF79747E)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true, fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(
                obscureConfirm ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
            ),
          ),
          style: TextStyle(
            color: const Color(0xFF303030),
            fontSize: isDesktop ? 16 : 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: !passwordsMatch || loading
                ? null
                : () async {
                    setState(() => loading = true);
                    final payload = {
                        "code": widget.code,
                        "email": widget.email,
                        "new_password": passwordController.text,
                      };
                    print('Sending payload: $payload'); // ✅ Debug print
                    final response = await http.post(
                      Uri.parse('https://api.tuneyverse.com/auth/reset-password'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode(payload),
                    );
                    print('Status code: ${response.statusCode}'); // ✅ Debug print
                    print('Response body: ${response.body}');     // ✅ Debug print
                                setState(() => loading = false);
                    if (response.statusCode == 200) {
                      if (!mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => SignInPage()), // Use your real SignInPage
                        (route) => false,
                      );
                    } else {
                      final Map<String, dynamic>? body = response.body.isNotEmpty
                        ? jsonDecode(response.body)
                        : null;
                      final message = body?['message'] ??
                          'Failed to set password. Please try again.';
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF40367B),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 16 : 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
                side: const BorderSide(width: 1, color: Color(0xFF251F48)),
              ),
              elevation: 0,
            ),
            child: loading
                ? SizedBox(
                    height: 22, width: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : Text(
                    'SET PASSWORD',
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
        if (passwordController.text.isNotEmpty &&
            confirmController.text.isNotEmpty &&
            passwordController.text != confirmController.text)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "Passwords do not match.",
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }
}
