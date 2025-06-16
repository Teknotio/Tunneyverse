import 'package:flutter/material.dart';

class PricingPlansSection extends StatelessWidget {
  const PricingPlansSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) {
      return const _PricingPlansDesktop();
    } else {
      return const _PricingPlansMobile();
    }
  }
}

// ========================
// DESKTOP VIEW
// ========================
class _PricingPlansDesktop extends StatelessWidget {
  const _PricingPlansDesktop();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      color: const Color(0xFFF0EFFA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 768),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Affordable',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Pricing Plans',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 48,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Choose the perfect plan for your karaoke experience.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Toggle Buttons (Monthly/Yearly)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF5F51B9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(width: 1, color: Color(0xFF251F48)),
                      ),
                    ),
                    child: Text(
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
                    child: Text(
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
              const SizedBox(height: 48),

              // Pricing Cards Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PlanCard(
                    title: 'Basic',
                    price: '\$19',
                    desc: 'Perfect for beginners and casual users.',
                  ),
                  const SizedBox(width: 16),
                  _PlanCard(
                    title: 'Business',
                    price: '\$29',
                    desc: 'Ideal for small teams.',
                  ),
                  const SizedBox(width: 16),
                  _PlanCard(
                    title: 'Enterprise',
                    price: '\$49',
                    desc: 'Best for large organizations.',
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Feature Table
              _DesktopFeatureTable(),
              const SizedBox(height: 32),

              // Get Started Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _GetStartedButton(),
                  const SizedBox(width: 32),
                  _GetStartedButton(),
                  const SizedBox(width: 32),
                  _GetStartedButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Card for Pricing Plan
class _PlanCard extends StatelessWidget {
  final String title, price, desc;
  const _PlanCard({required this.title, required this.price, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: price,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  TextSpan(
                    text: '/mo',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Features Table for Desktop
class _DesktopFeatureTable extends StatelessWidget {
  const _DesktopFeatureTable();

  // Data format: featureName, [basic, business, enterprise]
  final List<Map<String, List<String?>>> _features = const [
    {'Vocal Extraction': ['10', '25', 'Unlimited']},
    {'Custom Track Creation': [null, null, null]},
    {'Karaoke Video Generation': [null, null, null]},
    {'Lyrics Synchronization': [null, null, null]},
    {'User Testing Area': [null, null, '✓']},
    {'Fast Processing': ['10', '25', 'Unlimited']},
    {'Cross-Platform Support': [null, null, null]},
    {'Educational Use Cases': [null, null, null]},
    {'Commercial Use Cases': [null, null, null]},
    {'Intuitive Onboarding': [null, null, '✓']},
    {'Priority Support': ['10', '25', 'Unlimited']},
    {'Custom Branding Options': [null, null, null]},
    {'Advanced Analytics': [null, null, null]},
    {'Team Collaboration Tools': [null, null, null]},
    {'Extended Storage': [null, null, '✓']},
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(260),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
      },
      border: TableBorder.all(color: Colors.black12),
      children: [
        // Table header
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Features',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ...['Basic', 'Business', 'Enterprise'].map((e) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    e,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )),
          ],
        ),
        // Table rows
        ..._features.map((row) {
          final name = row.keys.first;
          final values = row.values.first;
          return TableRow(
            decoration: BoxDecoration(color: Colors.white),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(name),
              ),
              ...values.map((v) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: v == null
                        ? const SizedBox(width: 24, height: 24)
                        : v == '✓'
                            ? const Icon(Icons.check, color: Colors.green)
                            : Text(
                                v,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                  )),
            ],
          );
        }),
      ],
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0xFF5F51B9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(width: 1, color: Color(0xFF5F51B9)),
        ),
      ),
      child: const Text(
        'Get started',
        style: TextStyle(
          color: Color(0xFFF0EFFA),
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }
}

// ========================
// MOBILE VIEW
// ========================
class _PricingPlansMobile extends StatelessWidget {
  const _PricingPlansMobile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      color: const Color(0xFFF0EFFA),
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Text(
                  'Affordable',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Pricing Plans',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Choose the perfect plan for your karaoke experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                // Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF5F51B9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(width: 1, color: Color(0xFF251F48)),
                        ),
                      ),
                      child: Text(
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
                      child: Text(
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
                const SizedBox(height: 32),

                // Pricing Cards (Column)
                _PlanCard(
                  title: 'Basic',
                  price: '\$19',
                  desc: 'Perfect for beginners and casual users.',
                ),
                const SizedBox(height: 16),
                _PlanCard(
                  title: 'Business',
                  price: '\$29',
                  desc: 'Ideal for small teams.',
                ),
                const SizedBox(height: 16),
                _PlanCard(
                  title: 'Enterprise',
                  price: '\$49',
                  desc: 'Best for large organizations.',
                ),
                const SizedBox(height: 32),

                // Feature Table (Mobile Version)
                _MobileFeatureTable(),
                const SizedBox(height: 32),

                // Get Started Buttons
                _GetStartedButton(),
                const SizedBox(height: 24),
                _GetStartedButton(),
                const SizedBox(height: 24),
                _GetStartedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// A simple table for features on mobile (adapted)
class _MobileFeatureTable extends StatelessWidget {
  const _MobileFeatureTable();

  // You can adjust these features for mobile
  final List<Map<String, String?>> _features = const [
    {'Vocal Extraction': '10/25/Unlimited'},
    {'Custom Track Creation': '✓'},
    {'Karaoke Video Generation': '✓'},
    {'Lyrics Synchronization': '✓'},
    {'Fast Processing': '10/25/Unlimited'},
    {'Cross-Platform Support': '✓'},
    {'Educational Use Cases': '✓'},
    {'Commercial Use Cases': '✓'},
    {'Intuitive Onboarding': '✓'},
    {'Priority Support': '10/25/Unlimited'},
    {'Custom Branding Options': '✓'},
    {'Advanced Analytics': '✓'},
    {'Team Collaboration Tools': '✓'},
    {'Extended Storage': '✓'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        ..._features.map((f) {
          final key = f.keys.first;
          final value = f.values.first;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    key,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                if (value == '✓')
                  Icon(Icons.check, color: Colors.green, size: 18)
                else
                  Text(
                    value ?? '',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
