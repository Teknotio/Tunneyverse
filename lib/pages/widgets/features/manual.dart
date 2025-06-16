import 'package:flutter/material.dart';

class ManualStepsWidget extends StatelessWidget {
  const ManualStepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return isDesktop ? _desktopView() : _mobileView();
  }

  Widget _desktopView() {
    return Container(
      width: 1440,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      decoration: const BoxDecoration(color: Color(0xFFF0EFFA)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 768,
              child: Text(
                'Discover How Easy It Is to Create Custom Music Tracks',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step 1
                Expanded(
                  child: _ManualStepCard(
                    imageAsset: "assets/images/upload_image.png",
                    title: "Step-by-Step Guide to Using Tuneyverse’s Innovative Features",
                    description: "Start by uploading your favorite song or video to Tuneyverse.",
                    actionText: "Upload",
                    icon: Icons.upload,
                  ),
                ),
                const SizedBox(width: 48),
                // Step 2
                Expanded(
                  child: _ManualStepCard(
                    imageAsset: "assets/images/select_image.png",
                    title: "Select Your Desired Processing Option for Customization",
                    description: "Choose from options like 'Chorus and Instrumental' or 'Instrumental Only'.",
                    actionText: "Select",
                    icon: Icons.tune,
                  ),
                ),
                const SizedBox(width: 48),
                // Step 3
                Expanded(
                  child: _ManualStepCard(
                    imageAsset: "assets/images/download_image.png",
                    title: "Receive Your Processed Track Instantly for Enjoyment or Practice",
                    description: "Download your custom karaoke track and start singing along with synced lyrics.",
                    actionText: "Download",
                    icon: Icons.download,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileView() {
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      decoration: const BoxDecoration(color: Color(0xFFF0EFFA)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 335,
            child: Text(
              'Discover How Easy It Is to Create Custom Karaoke Tracks',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 48),
          _ManualStepCard(
            imageAsset: "assets/images/upload_image.png",
            title: "Step-by-Step Guide to Using Tuneyverse’s Innovative Features",
            description: "Start by uploading your favorite song or video to Tuneyverse.",
            actionText: "Upload",
            icon: Icons.upload,
            isMobile: true,
          ),
          const SizedBox(height: 48),
          _ManualStepCard(
            imageAsset: "assets/images/select_image.png",
            title: "Select Your Desired Processing Option for Customization",
            description: "Choose from options like 'Chorus and Instrumental' or 'Instrumental Only'.",
            actionText: "Select",
            icon: Icons.tune,
            isMobile: true,
          ),
          const SizedBox(height: 48),
          _ManualStepCard(
            imageAsset: "assets/images/download_image.png",
            title: "Receive Your Processed Track Instantly for Enjoyment or Practice",
            description: "Download your custom karaoke track and start singing along with synced lyrics.",
            actionText: "Download",
            icon: Icons.download,
            isMobile: true,
          ),
        ],
      ),
    );
  }
}

class _ManualStepCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  final String actionText;
  final IconData? icon;
  final bool isMobile;

  const _ManualStepCard({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.actionText,
    this.icon,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image
        Container(
          width: isMobile ? double.infinity : 395,
          height: isMobile ? 198 : 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imageAsset),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        // Step Title
        SizedBox(
          width: isMobile ? 335 : 394.67,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 20 : 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        // Description
        SizedBox(
          width: isMobile ? 335 : 394.67,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        // Action Row (Upload, Select, Download)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              actionText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            const SizedBox(width: 8),
            icon != null
                ? Icon(icon, size: 22, color: Colors.black)
                : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
