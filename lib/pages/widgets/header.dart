import 'package:flutter/material.dart';

class ResponsiveHeader extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;

  const ResponsiveHeader({super.key, this.onLogin, this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return _DesktopHeader(onLogin: onLogin, onSignUp: onSignUp);
        } else {
          return _MobileHeader(onLogin: onLogin, onSignUp: onSignUp);
        }
      },
    );
  }
}

// LOGO + NAME WIDGET (for reuse)
class _LogoName extends StatelessWidget {
  const _LogoName();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 40,
          width: 40,
        ),
        const SizedBox(width: 10),
        const Text(
          'Tuneyverse',
          style: TextStyle(
            color: Color(0xFF50449A),
            fontSize: 28.15,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 1.06,
          ),
        ),
      ],
    );
  }
}

// DESKTOP HEADER
class _DesktopHeader extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;
  const _DesktopHeader({this.onLogin, this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 64),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _LogoName(),
          Row(
            children: [
              _NavButton(title: 'Home'),
              _NavButton(title: 'Features', hasDropdown: true),
              _NavButton(title: 'Pricing'),
              _NavButton(title: 'Support', hasDropdown: true),
              const SizedBox(width: 32),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF50449A)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                onPressed: onLogin ?? () {},
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF50449A),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF50449A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                onPressed: onSignUp ?? () {},
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final bool hasDropdown;
  final VoidCallback? onTap;

  const _NavButton({
    required this.title,
    this.hasDropdown = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextButton(
        onPressed: onTap ?? () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
            ]
          ],
        ),
      ),
    );
  }
}

// MOBILE HEADER
class _MobileHeader extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;
  const _MobileHeader({this.onLogin, this.onSignUp});

  @override
  Widget build(BuildContext context) {
    // Using Builder to get Scaffold context for Drawer
    return Builder(
      builder: (ctx) => Container(
        width: double.infinity,
        height: 64,
        padding: const EdgeInsets.only(left: 20, right: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _LogoName(),
            IconButton(
              icon: const Icon(Icons.menu, size: 32, color: Color(0xFF50449A)),
              onPressed: () => Scaffold.of(ctx).openEndDrawer(),
            ),
          ],
        ),
      ),
    );
  }
}

// MOBILE DRAWER
// ignore: unused_element
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          children: [
            const _LogoName(),
            const SizedBox(height: 20),
            _NavButton(
              title: 'Home',
              onTap: () => Navigator.of(context).maybePop(),
            ),
            _NavButton(
              title: 'Features',
              hasDropdown: true,
              onTap: () => Navigator.of(context).maybePop(),
            ),
            _NavButton(
              title: 'Pricing',
              onTap: () => Navigator.of(context).maybePop(),
            ),
            _NavButton(
              title: 'Support',
              hasDropdown: true,
              onTap: () => Navigator.of(context).maybePop(),
            ),
            const Divider(height: 32),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF50449A)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              onPressed: () {}, // You can also use onLogin here if you want
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF50449A),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF50449A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              onPressed: () {}, // Or use onSignUp
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
