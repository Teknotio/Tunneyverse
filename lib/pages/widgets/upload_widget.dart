import 'package:flutter/material.dart';

// Responsive Upload Widget
class ResponsiveUploadWidget extends StatelessWidget {
  const ResponsiveUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width >= 1000) {
      return const _DesktopUpload();
    } else if (width >= 600) {
      return const _TabletUpload();
    } else {
      return const _MobileUpload();
    }
  }
}

// ================= Desktop =================
class _DesktopUpload extends StatelessWidget {
  const _DesktopUpload();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1136,
      height: 488,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 31),
      decoration: ShapeDecoration(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Stack(
        children: [
          // Header
          Positioned(
            left: 21,
            top: 29,
            child: Text(
              'Select package & choose files',
              style: TextStyle(
                color: const Color(0xFF1B191C),
                fontSize: 40,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.10,
              ),
            ),
          ),
          // "Vocal and Instrumental"
          Positioned(
            left: 0,
            top: 110,
            child: Container(
              width: 546,
              height: 96,
              decoration: ShapeDecoration(
                color: const Color(0x141B191C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 32),
                child: Text(
                  'Vocal and Instrumental',
                  style: TextStyle(
                    color: const Color(0xFF1B191C),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ),
            ),
          ),
          // "Select Files" Button
          Positioned(
            left: 0,
            top: 210,
            child: Container(
              width: 546,
              height: 98,
              decoration: ShapeDecoration(
                color: const Color(0xFF50449A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Center(
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
          // "Paste File Here"
          Positioned(
            left: 353,
            top: 236,
            child: Text(
              'Paste File Here',
              style: TextStyle(
                color: const Color(0x191B191C),
                fontSize: 64,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Tablet =================
class _TabletUpload extends StatelessWidget {
  const _TabletUpload();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 581,
      height: 735,
      decoration: ShapeDecoration(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Stack(
        children: [
          // Header
          Positioned(
            left: 21,
            top: 29,
            child: Text(
              'Select package & choose files',
              style: TextStyle(
                color: const Color(0xFF1B191C),
                fontSize: 40,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.10,
              ),
            ),
          ),
          // Main Column for "Vocal..." and "Select Files"
          Positioned(
            left: 17.5,
            top: 503,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 546,
                  height: 96,
                  decoration: ShapeDecoration(
                    color: const Color(0x141B191C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, top: 32),
                    child: Text(
                      'Vocal and Instrumental',
                      style: TextStyle(
                        color: const Color(0xFF1B191C),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Container(
                  width: 546,
                  height: 98,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF50449A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Center(
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
              ],
            ),
          ),
          // "Paste File Here"
          Positioned(
            left: 76,
            top: 360,
            child: Text(
              'Paste File Here',
              style: TextStyle(
                color: const Color(0x191B191C),
                fontSize: 64,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Mobile =================
class _MobileUpload extends StatelessWidget {
  const _MobileUpload();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: ShapeDecoration(
        color: const Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          SizedBox(
            width: 314,
            child: Text(
              'Select package  & choose files',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1B191C),
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.38,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // "Paste File Here"
          SizedBox(
            width: 219,
            child: Text(
              'Paste File Here',
              style: TextStyle(
                color: const Color(0x191B191C),
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.50,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // "Vocal and Instrumental" & "Select Files" Button
          SizedBox(
            width: 295,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCDCDC),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 157,
                        height: 30,
                        child: Text(
                          'Vocal and Instrumental',
                          style: TextStyle(
                            color: const Color(0xFF1B191C),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 2.29,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 33),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF6A5ACD),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Center(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
