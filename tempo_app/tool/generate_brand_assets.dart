// Renders the Tempo mark (TempoLogo) into every icon and splash image.
//
//   flutter test tool/generate_brand_assets.dart
//   dart run flutter_native_splash:create --path=flutter_native_splash.yaml
//
// It runs as a widget test so the real Material icon font draws the glyph.
// It lives outside test/ so `flutter test` doesn't regenerate files.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/ui/core/widgets/tempo_logo.dart';

/// Output path → (pixel size, shape).
const _assets = <String, (int, TempoLogoShape)>{
  'web/favicon.png': (64, TempoLogoShape.rounded),
  'web/icons/Icon-192.png': (192, TempoLogoShape.rounded),
  'web/icons/Icon-512.png': (512, TempoLogoShape.rounded),
  'web/icons/Icon-maskable-192.png': (192, TempoLogoShape.fullBleed),
  'web/icons/Icon-maskable-512.png': (512, TempoLogoShape.fullBleed),
};

/// Splash glyph: white stopwatch on the blue splash background. Images are
/// read as xxxhdpi (4x), so 384 px of glyph is 96 dp, the same size the
/// in-app LaunchOverlay draws, so the hand-over is seamless.
const _splashGlyph = 384;
const _splashCanvas = 480;

/// Android 12+ splash icon without an icon background: 1152×1152 px, of
/// which the central 768 px circle shows.
const _android12Canvas = 1152;

void main() {
  setUpAll(() async {
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });

  testWidgets('generate brand assets', (tester) async {
    for (final MapEntry(key: path, value: (size, shape)) in _assets.entries) {
      await _render(
        tester,
        path,
        canvas: size,
        child: TempoLogo(size: size.toDouble(), shape: shape),
      );
    }
    for (final (path, canvas) in [
      ('branding/splash_logo.png', _splashCanvas),
      ('branding/splash_android12.png', _android12Canvas),
    ]) {
      await _render(
        tester,
        path,
        canvas: canvas,
        child: const TempoLogo(
          size: _splashGlyph * 1.0,
          shape: TempoLogoShape.glyph,
        ),
      );
    }
  });
}

Future<void> _render(
  WidgetTester tester,
  String path, {
  required int canvas,
  required Widget child,
}) async {
  tester.view
    ..physicalSize = Size.square(canvas.toDouble())
    ..devicePixelRatio = 1;
  final key = GlobalKey();
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          key: key,
          child: SizedBox.square(
            dimension: canvas.toDouble(),
            child: Center(child: child),
          ),
        ),
      ),
    ),
  );
  await tester.pump();

  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File(path);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes!.buffer.asUint8List());
  });
  // ignore: avoid_print
  print('wrote $path (${canvas}x$canvas)');
}
