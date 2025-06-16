import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ChorusAndInstrumentalWidget extends StatefulWidget {
  const ChorusAndInstrumentalWidget({super.key});

  @override
  State<ChorusAndInstrumentalWidget> createState() => _ChorusAndInstrumentalWidgetState();
}

class _ChorusAndInstrumentalWidgetState extends State<ChorusAndInstrumentalWidget> {
  String selectedOption = 'Chorus and Instrumental';
  String? pickedFileName;
  DropzoneViewController? dropzoneController; // Only for web

  final List<String> options = [
    'Chorus and Instrumental',
    'Chorus and Lyric Video',
    'Song and Lyric Video',
    'Instrumental and Lyric Video',
    'Song Instrumental',
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
      // Optionally show a message or nothing
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return _DesktopChorusAndInstrumental(
        selectedOption: selectedOption,
        options: options,
        onChanged: (value) => setState(() => selectedOption = value!),
        onPickFile: _pickFile,
        onFileDropped: _setFile,
        pickedFileName: pickedFileName,
        dropzoneController: dropzoneController,
        onDropzoneCreated: (ctrl) => dropzoneController = ctrl,
      );
    } else {
      return _MobileChorusAndInstrumental(
        selectedOption: selectedOption,
        options: options,
        onChanged: (value) => setState(() => selectedOption = value!),
        onPickFile: _pickFile,
        pickedFileName: pickedFileName,
        dropzoneController: dropzoneController,
        onDropzoneCreated: (ctrl) => dropzoneController = ctrl,
      );
    }
  }
}

// DESKTOP VIEW (Web/Windows/macOS/Linux)
class _DesktopChorusAndInstrumental extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final VoidCallback onPickFile;
  final Function(String) onFileDropped;
  final String? pickedFileName;
  final DropzoneViewController? dropzoneController;
  final void Function(DropzoneViewController) onDropzoneCreated;

  const _DesktopChorusAndInstrumental({
    required this.selectedOption,
    required this.options,
    required this.onChanged,
    required this.onPickFile,
    required this.onFileDropped,
    required this.pickedFileName,
    required this.dropzoneController,
    required this.onDropzoneCreated,
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
              'Chorus and Instrumental',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 1000,
            child: Text(
              'AI vocal remover that keeps instrumentals and chorus, perfect for karaoke, remixes, and videos.',
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
                // "Paste File Here"
                Positioned(
                  left: 353,
                  top: 206,
                  child: GestureDetector(
                    onTap: onPickFile,
                    child: Column(
                      children: [
                        Text(
                          pickedFileName ?? (isWeb ? 'Drag & drop or click to select file' : 'Paste File Here'),
                          style: const TextStyle(
                            color: Color(0x191B191C),
                            fontSize: 64,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0.25,
                          ),
                        ),
                        if (pickedFileName != null)
                          Text(
                            'File ready: $pickedFileName',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Dropdown
                Positioned(
                  left: 12,
                  top: 371,
                  child: Container(
                    width: 546,
                    height: 96,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0x141B191C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedOption,
                          onChanged: onChanged,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          items: options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(
                                option,
                                style: const TextStyle(
                                  color: Color(0xFF1B191C),
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                // Select Files Button
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
              '* By uploading a file, you agree to our Terms of Service.',
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

// MOBILE VIEW
class _MobileChorusAndInstrumental extends StatelessWidget {
  final String selectedOption;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final VoidCallback onPickFile;
  final String? pickedFileName;
  final DropzoneViewController? dropzoneController;
  final void Function(DropzoneViewController) onDropzoneCreated;

  const _MobileChorusAndInstrumental({
    required this.selectedOption,
    required this.options,
    required this.onChanged,
    required this.onPickFile,
    required this.pickedFileName,
    required this.dropzoneController,
    required this.onDropzoneCreated,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWeb = kIsWeb;
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Chorus and Instrumental',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 335,
            child: Text(
              'AI vocal remover that keeps instrumentals and chorus, perfect for karaoke, remixes, and videos.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF251F48),
                fontSize: 40,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 335,
            height: 669,
            child: Column(
              children: [
                GestureDetector(
                  onTap: onPickFile,
                  child: Container(
                    width: double.infinity,
                    height: 635,
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
                              onPickFile(); // Or call file dropped handler if you want
                            },
                            operation: DragOperation.copy,
                            cursor: CursorType.grab,
                          ),
                        Positioned(
                          left: 60,
                          top: 294,
                          child: Column(
                            children: [
                              Text(
                                pickedFileName ?? (isWeb ? 'Drag & drop or tap to select file' : 'Paste File Here'),
                                style: const TextStyle(
                                  color: Color(0x191B191C),
                                  fontSize: 32,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0.5,
                                ),
                              ),
                              if (pickedFileName != null)
                                Text(
                                  'File ready: $pickedFileName',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Dropdown
                        Positioned(
                          left: 24,
                          top: 403,
                          child: Container(
                            width: 287,
                            height: 96,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0x141B191C),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedOption,
                                  onChanged: onChanged,
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  items: options.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          color: Color(0xFF1B191C),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Select Files Button
                        Positioned(
                          left: 24,
                          top: 519,
                          child: GestureDetector(
                            onTap: onPickFile,
                            child: Container(
                              width: 287,
                              height: 98,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6A5ACD),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Text(
                                  'Select Files',
                                  style: TextStyle(
                                    color: Color(0xFFF0EFFA),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 335,
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
        ],
      ),
    );
  }
}
