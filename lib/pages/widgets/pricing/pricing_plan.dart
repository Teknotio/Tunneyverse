import 'package:flutter/material.dart';

class PricingPlanSection extends StatelessWidget {
  const PricingPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 64,
        vertical: isMobile ? 24 : 112,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFF0EFFA)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isMobile ? _MobileHeading() : _DesktopHeading(),
                const SizedBox(height: 48),
                // Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF30285C),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF5F51B9),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF5548A4),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Monthly',
                          style: TextStyle(
                            color: Color(0xFFF0EFFA),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: const Text(
                          'Yearly',
                          style: TextStyle(
                            color: Color(0xFF251F48),
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
                const SizedBox(height: 32),
                _PricingTable(isMobile: isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Mobile Headings
class _MobileHeading extends StatelessWidget {
  const _MobileHeading();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 768),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Affordable',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 335,
                    child: Text(
                      'Pricing Plans',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 335,
                    child: Text(
                      'Choose the perfect plan for your karaoke experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Desktop Headings
class _DesktopHeading extends StatelessWidget {
  const _DesktopHeading();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 768),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Affordable',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Pricing Plans',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 48,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Choose the perfect plan for your karaoke experience.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
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

// Feature Table (mobile and desktop)
class _PricingTable extends StatelessWidget {
  final bool isMobile;
  const _PricingTable({required this.isMobile});

  static const _planNames = ['Basic', 'Business', 'Enterprise'];
  static const _prices = ['\$19', '\$29', '\$49'];
  static const _descs = [
    'Perfect for beginners and casual users.',
    'Ideal for small teams.',
    'Best for large organizations.',
  ];

  static final List<List<String>> _featureOverview = [
    ['Vocal Extraction', '10', '25', 'Unlimited'],
    ['Custom Track Creation', '✓', '✓', '✓'],
    ['Karaoke Video Generation', '—', '✓', '✓'],
    ['Lyrics Synchronization', '—', '—', '✓'],
    ['User Testing Area', '—', '—', '✓'],
  ];

  static final List<List<String>> _additionalFeatures = [
    ['Fast Processing', '10', '25', 'Unlimited'],
    ['Cross-Platform Support', '✓', '✓', '✓'],
    ['Educational Use Cases', '—', '✓', '✓'],
    ['Commercial Use Cases', '—', '✓', '✓'],
    ['Intuitive Onboarding', '—', '—', '✓'],
  ];

  static final List<List<String>> _planBenefits = [
    ['Priority Support', '10', '25', 'Unlimited'],
    ['Custom Branding Options', '—', '—', '✓'],
    ['Advanced Analytics', '—', '—', '✓'],
    ['Team Collaboration Tools', '—', '—', '✓'],
    ['Extended Storage', '—', '—', '✓'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isMobile ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Table(
        columnWidths: isMobile
            ? const {
                0: FixedColumnWidth(120),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
              }
            : const {
                0: FixedColumnWidth(260),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
              },
        border: TableBorder.all(color: Colors.transparent),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Plan header row
          TableRow(
            children: [
              const SizedBox(),
              for (final name in _planNames)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 16 : 20,
                      height: 1.4,
                    ),
                  ),
                ),
            ],
          ),
          // Price row
          TableRow(
            children: [
              const SizedBox(),
              for (final price in _prices)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isMobile ? 24 : 40,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        TextSpan(
                          text: '/mo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isMobile ? 14 : 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
          // Description row
          TableRow(
            children: [
              const SizedBox(),
              for (final desc in _descs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: isMobile ? 13 : 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
            ],
          ),
          _featureSectionRow('Feature Overview', isMobile),
          ..._featureOverview.map((row) => _featureRow(row, isMobile)),
          _featureSectionRow('Additional Features', isMobile),
          ..._additionalFeatures.map((row) => _featureRow(row, isMobile)),
          _featureSectionRow('Plan Benefits', isMobile),
          ..._planBenefits.map((row) => _featureRow(row, isMobile)),
          // Button row
          TableRow(
            children: [
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 10, top: 8),
                child: _GetStartedButton(isMobile: isMobile),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: _GetStartedButton(isMobile: isMobile),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 10, top: 8),
                child: _GetStartedButton(isMobile: isMobile),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Now overflow-safe: just a Text widget, never wider than the column!
  static TableRow _featureSectionRow(String title, bool isMobile) {
    if (title == 'Feature Overview') {
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(
              'Feature Overview',
              style: TextStyle(
                color: Colors.black,
                fontSize: isMobile ? 18 : 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.40,
              ),
            ),
          ),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ],
      );
    }
    // Default for other section headers
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 14 : 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
      ],
    );
  }

  static TableRow _featureRow(List<String> row, bool isMobile) {
    return TableRow(
      decoration: BoxDecoration(
        color: isMobile ? const Color(0xFFF7F5FF) : Colors.transparent,
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 14, horizontal: isMobile ? 8 : 18),
          child: Text(
            row[0],
            style: TextStyle(
              fontSize: isMobile ? 12 : 16,
              color: Colors.black,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        for (int i = 1; i < 4; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 14),
            child: Center(child: _valueWidget(row[i], isMobile)),
          ),
      ],
    );
  }

  static Widget _valueWidget(String value, bool isMobile) {
    if (value == '✓') {
      return Icon(Icons.check, color: Color(0xFF5F51B9), size: isMobile ? 16 : 20);
    } else if (value == '—') {
      return Text('—',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: isMobile ? 12 : 16,
            color: Colors.grey,
            fontFamily: 'Roboto',
          ));
    }
    return Text(
      value,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: isMobile ? 12 : 16,
        color: Colors.black,
        fontFamily: 'Roboto',
      ),
      textAlign: TextAlign.center,
    );
  }
}

// Get Started Button (for each plan column)
class _GetStartedButton extends StatelessWidget {
  final bool isMobile;
  const _GetStartedButton({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: isMobile ? 10 : 12),
      decoration: ShapeDecoration(
        color: const Color(0xFF5F51B9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: const BorderSide(
            width: 1,
            color: Color(0xFF5F51B9),
          ),
        ),
      ),
      child: Center(
        child: Text(
          'Get started',
          style: TextStyle(
            color: Color(0xFFF0EFFA),
            fontSize: isMobile ? 14 : 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
