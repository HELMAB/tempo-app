import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:share_plus/share_plus.dart';

/// Hands files to the platform (share sheet; a download on the web) and
/// picks files to read.
class FileService {
  Future<void> shareText({
    required String fileName,
    required String mimeType,
    required String contents,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            utf8.encode(contents),
            mimeType: mimeType,
            name: fileName,
          ),
        ],
        fileNameOverrides: [fileName],
      ),
    );
  }

  /// Returns the picked file's text, or null when the user cancels.
  Future<String?> pickText({
    required String label,
    required List<String> extensions,
    required List<String> mimeTypes,
    required List<String> appleTypes,
  }) async {
    final file = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(
          label: label,
          extensions: extensions,
          mimeTypes: mimeTypes,
          uniformTypeIdentifiers: appleTypes,
        ),
      ],
    );
    return file?.readAsString();
  }
}
