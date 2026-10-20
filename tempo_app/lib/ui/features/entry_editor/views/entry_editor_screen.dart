import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

class EntryEditorScreen extends StatelessWidget {
  const EntryEditorScreen({super.key, this.entryId});

  /// Null when adding a new entry.
  final int? entryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScreenPlaceholder(
        title: entryId == null ? 'New entry' : 'Edit entry',
        prototype: '04 · Add edit entry.png',
      ),
    );
  }
}
