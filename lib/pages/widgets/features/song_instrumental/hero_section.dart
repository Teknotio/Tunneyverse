import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class SongInstrumentalWidget extends StatefulWidget {
  const SongInstrumentalWidget({super.key});

  @override
  State<SongInstrumentalWidget> createState() => _SongInstrumentalWidgetState();
}

class _SongInstrumentalWidgetState extends State<SongInstrumentalWidget> {
  String selectedOption = 'Song Instrumental';
  String? pickedFileName;
  DropzoneViewController? dropzoneController;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _dropdownKey = GlobalKey();

  final List<String> options = [
    'Song Instrumental',
    'Chorus and Instrumental',
    'Chorus and Lyric Video',
    'Song and Lyric Video',
    'Instrumental and Lyric Video',
  ];

  void _setFile(String name) {
    setState(() {
      pickedFileName = name;
    });
    // TODO: Upload logic here
  }

  Future<void> _pickFile() async {
    if (kIsWeb) {
      // On web, use Dropzone only
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'aac', 'mp4', 'mov', 'avi'],
      );
      if (result != null && result.files.isNotEmpty) {
        _setFile(result.files.first.name);
      }
    }
  }

  void _onDropdownChanged(String value) {
    setState(() => selectedOption = value);
  }

  // --------- SCROLL LOGIC ----------
  void _ensureDropdownVisible() {
    // Delay to make sure the UI is laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        // Find offset of the dropdown from the top of the screen
        final offset = box.localToGlobal(Offset.zero);
        final dropdownBottom = offset.dy + box.size.height + 250; // 250 is an estimate for dropdown height
        final screenHeight = MediaQuery.of(context).size.height;

        // If the dropdown would be cut off, scroll just enough to bring it into view
        if (dropdownBottom > screenHeight) {
          final scrollAmount = dropdownBottom - screenHeight + 16; // Add a little padding
          _scrollController.animateTo(
            _scrollController.offset + scrollAmount,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }
  // --------- END SCROLL LOGIC ----------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      controller: _scrollController,
      child: width >= 800
          ? _DesktopChorusAndInstrumental(
              selectedOption: selectedOption,
              options: options,
              onChanged: _onDropdownChanged,
              onPickFile: _pickFile,
              onFileDropped: _setFile,
              pickedFileName: pickedFileName,
              dropzoneController: dropzoneController,
              onDropzoneCreated: (ctrl) => dropzoneController = ctrl,
              dropdownKey: _dropdownKey,
              onDropdownTap: _ensureDropdownVisible,
            )
          : _MobileChorusAndInstrumental(
              selectedOption: selectedOption,
              options: options,
              onChanged: _onDropdownChanged,
              onPickFile: _pickFile,
              pickedFileName: pickedFileName,
              dropzoneController: dropzoneController,
              onDropzoneCreated: (ctrl) => dropzoneController = ctrl,
              dropdownKey: _dropdownKey,
              onDropdownTap: _ensureDropdownVisible,
            ),
    );
  }
}

// DESKTOP VIEW
class _DesktopChorusAndInstrumental extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final VoidCallback onPickFile;
  final Function(String) onFileDropped;
  final String? pickedFileName;
  final DropzoneViewController? dropzoneController;
  final void Function(DropzoneViewController) onDropzoneCreated;
  final GlobalKey dropdownKey;
  final VoidCallback onDropdownTap;

  const _DesktopChorusAndInstrumental({
    required this.selectedOption,
    required this.options,
    required this.onChanged,
    required this.onPickFile,
    required this.onFileDropped,
    required this.pickedFileName,
    required this.dropzoneController,
    required this.onDropzoneCreated,
    required this.dropdownKey,
    required this.onDropdownTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWeb = kIsWeb;
    return Container(
      width: 1440,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Song Instrumental',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 1000,
            child: Text(
              'AI vocal remover that keeps instrumentals, perfect for karaoke, remixes, and videos.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF251F48),
                fontSize: 56,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 1136,
            height: 488,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                if (isWeb)
                  DropzoneView(
                    onCreated: onDropzoneCreated,
                    onDrop: (ev) async {
                      final name = await dropzoneController?.getFilename(ev) ?? 'Unknown';
                      onFileDropped(name);
                    },
                    operation: DragOperation.copy,
                    cursor: CursorType.grab,
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pickedFileName ?? 'Paste File Here',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0x191B191C),
                          fontSize: 64,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.25,
                        ),
                      ),
                      if (pickedFileName != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'File ready: $pickedFileName',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Custom dropdown using PopupMenuButton (always opens below)
                Positioned(
                  left: 12,
                  top: 371,
                  child: Container(
                    key: dropdownKey,
                    width: 546,
                    height: 96,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0x141B191C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      // Wrap in GestureDetector to trigger scroll logic
                      child: GestureDetector(
                        onTap: onDropdownTap,
                        child: PopupMenuButton<String>(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                            maxWidth: 350,
                          ),
                          onSelected: onChanged,
                          itemBuilder: (context) => options
                              .map((option) => PopupMenuItem(
                                    value: option,
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        color: Color(0xFF1B191C),
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.33,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedOption,
                                  style: const TextStyle(
                                    color: Color(0xFF1B191C),
                                    fontSize: 24,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 1.33,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down, color: Colors.black, size: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 571,
                  top: 371,
                  child: GestureDetector(
                    onTap: onPickFile,
                    child: Container(
                      width: 546,
                      height: 98,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6A5ACD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Select Files',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF0EFFA),
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
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 524,
            child: Text(
              '* By uploading a file, you agree to our Terms of Service.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF251F48),
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MOBILE VIEW (custom dropdown below the button)
class _MobileChorusAndInstrumental extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final VoidCallback onPickFile;
  final String? pickedFileName;
  final DropzoneViewController? dropzoneController;
  final void Function(DropzoneViewController) onDropzoneCreated;
  final GlobalKey dropdownKey;
  final VoidCallback onDropdownTap;

  const _MobileChorusAndInstrumental({
    required this.selectedOption,
    required this.options,
    required this.onChanged,
    required this.onPickFile,
    required this.pickedFileName,
    required this.dropzoneController,
    required this.onDropzoneCreated,
    required this.dropdownKey,
    required this.onDropdownTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWeb = kIsWeb;
    final double cardWidth = MediaQuery.of(context).size.width < 335
        ? MediaQuery.of(context).size.width
        : 335.0;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Song Instrumental',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: cardWidth,
              child: Text(
                'AI vocal remover that keeps instrumentals, perfect for karaoke, remixes, and videos.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF251F48),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: cardWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: ShapeDecoration(
                color: const Color(0xFFEDEDED),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: cardWidth - 20,
                    child: Text(
                      'Select package  & choose files',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF1B191C),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: cardWidth - 110,
                    child: Text(
                      pickedFileName ?? 'Paste File Here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0x191B191C),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.50,
                      ),
                    ),
                  ),
                  if (pickedFileName != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'File ready: $pickedFileName',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  // Custom dropdown using PopupMenuButton
                  Container(
                    key: dropdownKey,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFDCDCDC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: onDropdownTap,
                      child: PopupMenuButton<String>(
                        constraints: const BoxConstraints(
                          minWidth: 200,
                          maxWidth: 350,
                        ),
                        onSelected: onChanged,
                        itemBuilder: (context) => options
                            .map((option) => PopupMenuItem(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: const TextStyle(
                                      color: Color(0xFF1B191C),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 2.29,
                                    ),
                                  ),
                                ))
                            .toList(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedOption,
                                style: const TextStyle(
                                  color: Color(0xFF1B191C),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 2.29,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A5ACD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        elevation: 0,
                      ),
                      onPressed: onPickFile,
                      child: const Text(
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
            const SizedBox(height: 16),
            SizedBox(
              width: cardWidth,
              child: Text(
                '* By uploading a file, you agree to our Terms of Service.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF251F48),
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
