import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_music_player_app/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  final String _artistName = 'Justin Bieber';
  final String _otherArtistName = 'Peterpan';
  final int _trackId = 1440661545;
  final String _mediaPlayerKey = 'media-player-component';

  group('end-to-end test', () {
    testWidgets('Search music by Artist', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('No music found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), _artistName);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('item_music_$_trackId')), findsOneWidget);
    });

    testWidgets('Playing Music', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('No music found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), _artistName);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('item_music_$_trackId')), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(ValueKey('item_music_$_trackId')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsOneWidget);
    });

    testWidgets('Paused Music', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('No music found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), _artistName);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('item_music_$_trackId')), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(ValueKey('item_music_$_trackId')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byKey(ValueKey('media-player-pause-button')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('media-player-play-button')), findsOneWidget);
    });

    testWidgets('Repeat Music', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('No music found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), _artistName);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('item_music_$_trackId')), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(ValueKey('item_music_$_trackId')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsOneWidget);
      await tester.pumpAndSettle(Duration(minutes: 1));

      await tester.tap(find.byKey(ValueKey('media-player-repeat-button')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('media-player-pause-button')), findsOneWidget);
    });

    testWidgets('Search while music playing', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('No music found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), _artistName);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('item_music_$_trackId')), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(ValueKey('item_music_$_trackId')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 4));

      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), _otherArtistName);
      await tester.pumpAndSettle(Duration(seconds: 3));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsOneWidget);
    });

    testWidgets('Search while music not playing', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('No music found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), _artistName);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey('item_music_$_trackId')), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byKey(ValueKey('item_music_$_trackId')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 4));

      await tester.tap(find.byKey(ValueKey('media-player-pause-button')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), _otherArtistName);
      await tester.pumpAndSettle(Duration(seconds: 3));

      expect(find.byKey(ValueKey(_mediaPlayerKey)), findsNothing);
    });
  });
}
