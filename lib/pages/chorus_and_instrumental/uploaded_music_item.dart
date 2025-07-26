enum MediaType { music, video }

class UploadedMusicItem {
  final String? coverUrl;      // local file path or null
  final String title;
  final String artist;
  final String duration;
  final String filePath;
  final MediaType mediaType;

  UploadedMusicItem({
    this.coverUrl,
    required this.title,
    required this.artist,
    required this.duration,
    required this.filePath,
    required this.mediaType,
  });
}
