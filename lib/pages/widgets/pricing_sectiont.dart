import 'package:flutter/material.dart';

// Features for each plan
const _basicFeatures = [
  'Vocal extraction feature',
  'Custom track creation',
  'Karaoke video generation',
];

const _businessFeatures = [
  'Lyrics synchronization',
  'User testing area',
  'Instant demo access',
  'All basic features',
];

const _enterpriseFeatures = [
  'Advanced analytics tools',
  'Priority customer support',
  'Extended file uploads',
  'Custom branding options',
  'Collaborative features',
];

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop if > 800px, else mobile
        final isDesktop = constraints.maxWidth > 800;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 20,
            vertical: isDesktop ? 112 : 64,
          ),
          color: const Color(0xFFE9E6F8),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _Header(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 80 : 48),
                  _Toggle(isDesktop: isDesktop),
                  SizedBox(height: isDesktop ? 48 : 48),
                  isDesktop
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              Expanded(
                                child: _PricingCard(
                                  title: "Basic Plan",
                                  price: "\$19/mo",
                                  titleFontSize: 20,
                                  priceFontSize: 56,
                                  features: _basicFeatures,
                                ),
                              ),
                              SizedBox(width: 32),
                              Expanded(
                                child: _PricingCard(
                                  title: "Business Plan",
                                  price: "\$29/mo",
                                  titleFontSize: 20,
                                  priceFontSize: 56,
                                  features: _businessFeatures,
                                ),
                              ),
                              SizedBox(width: 32),
                              Expanded(
                                child: _PricingCard(
                                  title: "Enterprise Plan",
                                  price: "\$49/mo",
                                  titleFontSize: 20,
                                  priceFontSize: 56,
                                  features: _enterpriseFeatures,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            _PricingCard(
                              title: "Basic Plan",
                              price: "\$19/mo",
                              titleFontSize: 18,
                              priceFontSize: 40,
                              features: _basicFeatures,
                            ),
                            SizedBox(height: 32),
                            _PricingCard(
                              title: "Business Plan",
                              price: "\$29/mo",
                              titleFontSize: 18,
                              priceFontSize: 40,
                              features: _businessFeatures,
                            ),
                            SizedBox(height: 32),
                            _PricingCard(
                              title: "Enterprise Plan",
                              price: "\$49/mo",
                              titleFontSize: 18,
                              priceFontSize: 40,
                              features: _enterpriseFeatures,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final bool isDesktop;
  const _Header({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isDesktop ? 768 : 335),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Pricing',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF251F48),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: isDesktop ? 16 : 12),
          Text(
            'Pricing Plans',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF251F48),
              fontSize: isDesktop ? 48 : 36,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: isDesktop ? 24 : 20),
          Text(
            'Choose the perfect plan for your karaoke experience',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF251F48),
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

class _Toggle extends StatelessWidget {
  final bool isDesktop;
  const _Toggle({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: isDesktop ? Colors.white : const Color(0xFFF0EFFA),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF251F48),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: ShapeDecoration(
              color: isDesktop ? const Color(0xFF30285C) : const Color(0xFF251F48),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: isDesktop ? const Color(0xFF30285C) : const Color(0xFFF0EFFA),
                ),
              ),
            ),
            child: Text(
              'Monthly',
              style: TextStyle(
                color: const Color(0xFFF0EFFA),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              'Yearly',
              style: TextStyle(
                color: const Color(0xFF251F48),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final double titleFontSize;
  final double priceFontSize;
  final List<String> features;

  const _PricingCard({
    required this.title,
    required this.price,
    required this.titleFontSize,
    required this.priceFontSize,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: ShapeDecoration(
        color: const Color(0xFF251F48),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF251F48),
          ),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFF0EFFA),
                    fontSize: titleFontSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFF0EFFA),
                    fontSize: priceFontSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: features
                    .map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check, color: Color(0xFFF0EFFA), size: 22),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                f,
                                style: const TextStyle(
                                  color: Color(0xFFF0EFFA),
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
                    )
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF0EFFA),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Get started',
                style: TextStyle(
                  color: Color(0xFF251F48),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
