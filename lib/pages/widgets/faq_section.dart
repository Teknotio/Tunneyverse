import 'package:flutter/material.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 20,
            vertical: isDesktop ? 112 : 64,
          ),
          color: Colors.white,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _FAQHeader(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 80 : 48),
                  _FAQList(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 80 : 48),
                  _FAQContact(isDesktop: isDesktop),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FAQHeader extends StatelessWidget {
  final bool isDesktop;
  const _FAQHeader({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isDesktop ? 768 : 335),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'FAQs',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF50449A),
              fontSize: isDesktop ? 48 : 36,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: isDesktop ? 24 : 20),
          Text(
            'Here are some frequently asked questions about Tuneyverse and how it works.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: isDesktop ? 18 : 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// This now uses StatefulWidget to manage the open/close state of each FAQ.
class _FAQList extends StatefulWidget {
  final bool isDesktop;
  const _FAQList({required this.isDesktop});

  @override
  State<_FAQList> createState() => _FAQListState();
}

class _FAQListState extends State<_FAQList> {
  // Only one open at a time, or use List<bool> if you want multiple open.
  int? openIndex;

  static const faqs = [
    [
      'What is Tuneyverse?',
      'Tuneyverse is an AI-powered platform designed for creating custom karaoke tracks. Users can upload songs or videos and instantly generate karaoke versions with various options. It\'s perfect for musicians, vocalists, and karaoke enthusiasts.'
    ],
    [
      'How does pricing work?',
      'Tuneyverse offers both free and paid plans to suit different needs. The pricing is transparent and easy to understand, allowing users to choose the best option for them. You can compare packages directly on our website.'
    ],
    [
      'How to get started?',
      'Getting started with Tuneyverse is simple! Just visit our homepage, select a processing option, and upload your song or video. You can test our product before signing up.'
    ],
    [
      'What features are available?',
      'Tuneyverse offers vocal extraction, custom track creation, and karaoke video generation with synchronized lyrics. Users can choose from various modes to create the perfect karaoke experience. Our AI ensures high-quality results every time.'
    ],
    [
      'Is it user-friendly?',
      'Absolutely! Tuneyverse is designed with a user-friendly interface for easy navigation. The onboarding process is fast and intuitive, making it accessible for everyone. You can start creating in just a few clicks.'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 768),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(faqs.length, (i) {
          final q = faqs[i][0];
          final a = faqs[i][1];
          final isOpen = openIndex == i;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top horizontal line above question
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    if (openIndex == i) {
                      openIndex = null;
                    } else {
                      openIndex = i;
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: isDesktop ? 20 : 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          q,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isDesktop ? 18 : 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: isOpen ? 0.5 : 0.0, // Down: 0.0, Up: 0.5
                        child: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              // Answer and line if open
              if (isOpen)
                Padding(
                  padding: EdgeInsets.only(bottom: isDesktop ? 24 : 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          a,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              // Only for the last item: horizontal line after answer (always present)
              if (i == faqs.length - 1)
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _FAQContact extends StatelessWidget {
  final bool isDesktop;
  const _FAQContact({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isDesktop ? 560 : 335),
      child: Column(
        children: [
          Text(
            'Still have questions?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF50449A),
              fontSize: isDesktop ? 32 : 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: isDesktop ? 16 : 12),
          Text(
            "We're here to help!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: isDesktop ? 18 : 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFF50449A),
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  'Contact',
                  style: TextStyle(
                    color: Color(0xFF50449A),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.5,
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
