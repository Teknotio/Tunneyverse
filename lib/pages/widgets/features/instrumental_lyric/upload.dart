// Unified cross-platform widget for Song and Lyric Video Upload
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SongInstrumentalUpload extends StatefulWidget {
  const SongInstrumentalUpload({super.key});

  @override
  State<SongInstrumentalUpload> createState() => _SongInstrumentalUploadState();
}

class _SongInstrumentalUploadState extends State<SongInstrumentalUpload> {
  String? pickedFileName;
  DropzoneViewController? dropzoneController;
  String selectedOption = 'Song and Lyric Video';

  final List<String> options = [
    'Song and Lyric Video',
    'Instrumental and Lyric Video',
    'Chorus and Instrumental',
    'Chorus and Lyric Video',
    'Song Instrumental',
  ];

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'mp4', 'aac', 'm4a'],
    );
    if (result != null && result.files.single.name.isNotEmpty) {
      setState(() {
        pickedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return isMobile ? _buildMobileView() : _buildDesktopView();
  }

  Widget _buildDesktopView() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedOption,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 1136,
              child: Text(
                'AI vocal remover that keeps song and generates lyric videos, perfect for karaoke and content creation.',
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
                  if (kIsWeb)
                    DropzoneView(
                      onCreated: (ctrl) => dropzoneController = ctrl,
                      onDrop: (ev) async {
                        final name = await dropzoneController!.getFilename(ev);
                        setState(() {
                          pickedFileName = name;
                        });
                      },
                      operation: DragOperation.copy,
                      cursor: CursorType.grab,
                    ),
                  Center(
                    child: GestureDetector(
                      onTap: _pickFile,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            pickedFileName ??
                                (kIsWeb
                                    ? 'Drag & drop or click to select file'
                                    : 'Paste File Here'),
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
                  Positioned(
                    left: 12,
                    top: 371,
                    child: _buildDropdown(546),
                  ),
                  Positioned(
                    left: 571,
                    top: 371,
                    child: GestureDetector(
                      onTap: _pickFile,
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
                '* By uploading a file, you agree to our Terms of Service.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF251F48),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedOption,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'AI vocal remover that keeps song and generates lyric videos, perfect for karaoke and content creation.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: Color(0xFF251F48),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 635,
              decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  if (kIsWeb)
                    DropzoneView(
                      onCreated: (ctrl) => dropzoneController = ctrl,
                      onDrop: (ev) async {
                        final name = await dropzoneController!.getFilename(ev);
                        setState(() {
                          pickedFileName = name;
                        });
                      },
                      operation: DragOperation.copy,
                      cursor: CursorType.grab,
                    ),
                  Center(
                    child: GestureDetector(
                      onTap: _pickFile,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            pickedFileName ??
                                (kIsWeb
                                    ? 'Drag & drop or tap to select file'
                                    : 'Paste File Here'),
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
                  ),
                  Positioned(
                    left: 24,
                    top: 403,
                    child: _buildDropdown(287),
                  ),
                  Positioned(
                    left: 24,
                    top: 519,
                    child: GestureDetector(
                      onTap: _pickFile,
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
                            textAlign: TextAlign.center,
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
            const SizedBox(height: 16),
            const Text(
              '* By uploading a file, you agree to our Terms of Service.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF251F48),
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(double width) {
    return Container(
      width: width,
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0x141B191C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            value: selectedOption,
            onChanged: (val) => setState(() => selectedOption = val!),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1B191C),
                  ),
                ),
              );
            }).toList(),
            buttonStyleData: const ButtonStyleData(height: 48),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }
}
