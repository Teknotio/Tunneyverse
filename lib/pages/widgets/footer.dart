import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResponsiveFooter extends StatelessWidget {
  const ResponsiveFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      color: const Color(0xFF2D2654), // dark purple background
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Navigation Links
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 18 : 32,
            runSpacing: 8,
            children: [
              _FooterNavLink('Home'),
              _FooterNavLink('Services', hasDropdown: true),
              _FooterNavLink('Blog'),
              _FooterNavLink('Help Center'),
              _FooterNavLink('About'),
            ],
          ),
          const SizedBox(height: 32),
          // Social Icons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            children: [
              FaIcon(FontAwesomeIcons.youtube, color: Colors.white, size: 24),
              FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 24),
              FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 24),
              FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 24),
              FaIcon(FontAwesomeIcons.linkedinIn, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 24),
          // Copyright
          Text(
            "Tuneyverse @ 2025. All rights reserved.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isMobile ? 13 : 15,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FooterNavLink extends StatelessWidget {
  final String label;
  final bool hasDropdown;

  const _FooterNavLink(this.label, {this.hasDropdown = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (hasDropdown)
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 18,
          ),
      ],
    );
  }
}
