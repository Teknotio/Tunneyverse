import 'package:flutter/material.dart';

class ResponsiveFooter extends StatelessWidget {
  const ResponsiveFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Container(
      width: double.infinity,
      color: const Color(0xFF251F48),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 48 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: isMobile
              ? _FooterMobile()
              : _FooterDesktop(),
        ),
      ),
    );
  }
}

// ----------- Mobile Layout -----------
class _FooterMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Nav Links
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ..._footerNavItems.map(
              (label) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Social links
            Column(
              children: _footerSocialItems
                  .map(
                    (label) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                              color: Color(0xFFF0EFFA),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        const SizedBox(height: 40),
        // Divider & Policy section
        Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFF0EFFA),
                    width: 1,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ..._footerPolicyItems.map(
                  (label) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFF0EFFA),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '© 2025 Tuneyverse. All rights reserved.',
                  style: const TextStyle(
                    color: Color(0xFFF0EFFA),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ----------- Desktop Layout -----------
class _FooterDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Nav links
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 8,
          children: _footerNavItems
              .map(
                (label) => Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 32),
        // Social links row
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 8,
          children: _footerSocialItems
              .map(
                (label) => Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFF0EFFA),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 32),
        // Divider
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF0EFFA),
                width: 1,
              ),
            ),
          ),
        ),
        // Policies and copyright
        Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 32,
              children: _footerPolicyItems
                  .map(
                    (label) => Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFF0EFFA),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        height: 1.5,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text(
              '© 2025 Tuneyverse. All rights reserved.',
              style: const TextStyle(
                color: Color(0xFFF0EFFA),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}

// ----------- Static Footer Data -----------
const _footerNavItems = [
  'Home',
  'Features',
  'Blog',
  'Help Center',
  'About',
];

const _footerSocialItems = [
  'Youtube',
  'Facebook',
  'X',
  'Instagram',
  'LinkedIn',
];

const _footerPolicyItems = [
  'Privacy Policy',
  'Terms of Service',
  'Cookies Settings',
];
