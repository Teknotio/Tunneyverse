import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ResponsiveHeader extends StatefulWidget {
  const ResponsiveHeader({super.key});

  @override
  State<ResponsiveHeader> createState() => _ResponsiveHeaderState();
}

class _ResponsiveHeaderState extends State<ResponsiveHeader> {
  String selectedLanguage = 'English';

  final List<String> languages = [
    'English',
    'French',
    'Arabic',
    'Chinese',
    'Spanish',
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D5DD3), Color(0xFF4DB7F2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.music_note, color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Tunneyverse",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff211A3F),
                ),
              ),
            ],
          ),
          if (!isMobile) ...[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MenuItem(title: "Karoke Package", hasDropdown: true),
                  const SizedBox(width: 24),
                  _MenuItem(title: "Apps"),
                  const SizedBox(width: 24),
                  _MenuItem(title: "Pricing", hasDropdown: true),
                  const SizedBox(width: 24),
                  _MenuItem(title: "Guides"),
                  const SizedBox(width: 24),
                  _MenuItem(title: "About"),
                  const SizedBox(width: 24),
                  _MenuItem(title: "Blog"),
                ],
              ),
            ),
            _LanguageSelector(
              selectedLanguage: selectedLanguage,
              languages: languages,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
            const SizedBox(width: 16),
            const _GetStartedButton(),
          ],
          if (isMobile) const Spacer(),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF6D5DD3), size: 30),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final bool hasDropdown;
  const _MenuItem({required this.title, this.hasDropdown = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Color(0xff211A3F),
            fontSize: 16,
          ),
        ),
        if (hasDropdown)
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xff211A3F)),
      ],
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final List<String> languages;
  final ValueChanged<String?> onChanged;

  const _LanguageSelector({
    required this.selectedLanguage,
    required this.languages,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44, // match button height
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: false,
          customButton: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: const Color(0xFFE6E6EB), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedLanguage,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff211A3F),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.keyboard_arrow_down, color: Color(0xff211A3F)),
              ],
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            width: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          items: languages
              .map((lang) => DropdownMenuItem<String>(
                    value: lang,
                    child: Text(
                      lang,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff211A3F),
                        fontSize: 15,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedLanguage,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF50449A), // CTA color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          elevation: 0,
        ),
        onPressed: () {
          debugPrint("Get started button pressed!");
          // Replace with your navigation or logic
        },
        child: const Text(
          "Get started",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
