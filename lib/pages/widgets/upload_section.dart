import 'package:flutter/material.dart';

class UploadSection extends StatelessWidget {
  const UploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return const _DesktopUploadSection();
    } else {
      return const _MobileUploadSection();
    }
  }
}

// DESKTOP VIEW
class _DesktopUploadSection extends StatelessWidget {
  const _DesktopUploadSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      color: const Color(0xFF30285C),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main Title
          Text(
            'Transform Your Music Experience with AI',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 56,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.20,
            ),
          ),
          const SizedBox(height: 48),
          // Upload Card
          Center(
            child: Container(
              width: 1136,
              height: 488,
              decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Upload Section Title
                  const Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      'Select package & choose files',
                      style: TextStyle(
                        color: Color(0xFF1B191C),
                        fontSize: 40,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.10,
                      ),
                    ),
                  ),
                  // Select Files Button
                  Positioned(
                    left: 571,
                    top: 371,
                    child: SizedBox(
                      width: 546,
                      height: 98,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF50449A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          // TODO: Add file picker logic here
                        },
                        child: const Center(
                          child: Text(
                            'Select Files',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // File Type Selection with Dropdown
                  Positioned(
                    left: 12,
                    top: 371,
                    child: Container(
                      width: 546,
                      height: 96,
                      decoration: BoxDecoration(
                        color: const Color(0x141B191C),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 50,
                            top: 32,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                // TODO: Implement dropdown logic
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Vocal and Instrumental',
                                    style: TextStyle(
                                      color: Color(0xFF1B191C),
                                      fontSize: 24,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.33,
                                    ),
                                  ),
                                  const SizedBox(width: 150),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    size: 32,
                                    color: Color(0xFF50449A),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Paste File Here Text
                  const Positioned(
                    left: 375,
                    top: 182,
                    child: Text(
                      'Paste File Here',
                      style: TextStyle(
                        color: Color(0x191B191C),
                        fontSize: 64,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          // Terms of Service
          SizedBox(
            width: 524,
            child: Text(
              '* By uploading a file, you agree to our Terms of Service.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MOBILE VIEW
class _MobileUploadSection extends StatelessWidget {
  const _MobileUploadSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF30285C),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Title
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Center(
              child: Text(
                'Transform Your Music Experience with AI',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFF0EFFA),
                  fontSize: 40,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                ),
              ),
            ),
          ),
          // Upload Card
          Container(
            width: double.infinity,
            height: 620,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                const Positioned(
                  left: 11,
                  top: 36,
                  child: SizedBox(
                    width: 314,
                    child: Text(
                      'Select package  & choose files',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1B191C),
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                  ),
                ),
                // Select Files Button
                Positioned(
                  left: 20,
                  top: 502,
                  child: SizedBox(
                    width: 295,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A5ACD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        // TODO: Add file picker logic here
                      },
                      child: const Center(
                        child: Text(
                          'Select Files',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 2.29,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // File Type Selection with Dropdown
                Positioned(
                  left: 20,
                  top: 390,
                  child: Container(
                    width: 295,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () {
                        // TODO: Implement dropdown logic
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Vocal and Instrumental',
                            style: TextStyle(
                              color: Color(0xFF1B191C),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 2.29,
                            ),
                          ),
                          const SizedBox(width: 50),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Color(0xFF50449A),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                // Paste File Here
                const Positioned(
                  left: 58.34,
                  top: 248.63,
                  child: SizedBox(
                    width: 219,
                    child: Text(
                      'Paste File Here',
                      style: TextStyle(
                        color: Color(0x191B191C),
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Terms of Service
          Center(
            child: Text(
              '* By uploading a file, you agree to our Terms of Service.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
