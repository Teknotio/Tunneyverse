import 'package:flutter/material.dart';
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
    // Your unchanged desktop layout
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
  return Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFEDEDED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              // Title
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
              const SizedBox(height: 20),
              // Subtitle
              SizedBox(
                width: 219,
                child: Text(
                  pickedFileName ?? 'Paste File Here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0x191B191C),
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0.50,
                  ),
                ),
              ),
              if (pickedFileName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'File ready: $pickedFileName',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              // Package Box and Select Files button
              SizedBox(
                width: 295,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown fills full width and matches button
                    Container(
                      width: double.infinity,
                      // Remove horizontal padding for full width dropdown
                      
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDCDCDC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          value: selectedOption,
                          items: options.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF1B191C),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => selectedOption = val!),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                          ),
                          buttonStyleData: const ButtonStyleData(
                            width: double.infinity, // Ensures full width
                            height: 48, // To match the height if you want
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Select Files button, also full width
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: _pickFile,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF6A5ACD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
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
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Dropzone for web
              if (kIsWeb)
                Container(
                  width: 295,
                  height: 80,
                  margin: const EdgeInsets.only(top: 10),
                  child: DropzoneView(
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
                ),
              // Terms
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
            ],
          ),
        ),
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
