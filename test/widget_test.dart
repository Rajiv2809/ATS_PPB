import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jejak_rasa/app.dart';

Future<void> _openHome(WidgetTester tester) async {
  await tester.pumpWidget(const JejakRasaApp());
  await tester.pump(const Duration(milliseconds: 1200));
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('login-name')), findsOneWidget);
  await tester.enterText(
    find.byKey(const ValueKey('login-name')),
    'Ayu',
  );
  await tester.tap(find.byKey(const ValueKey('login-button')));
  await tester.pumpAndSettle();
  expect(find.text('Halo, Ayu 👋'), findsOneWidget);
}

void main() {
  testWidgets('empty login name displays a helpful validation message', (
    tester,
  ) async {
    await tester.pumpWidget(const JejakRasaApp());
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('login-button')));
    await tester.pumpAndSettle();

    expect(find.text('Namamu belum diisi.'), findsOneWidget);
    expect(find.text('Halo, Ayu 👋'), findsNothing);
  });

  testWidgets('search filters foods and favorites update the profile', (
    tester,
  ) async {
    await _openHome(tester);

    await tester.tap(find.byKey(const ValueKey('nav-explore')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('food-search')), 'serabi');
    await tester.pumpAndSettle();

    expect(find.text('Serabi Solo'), findsOneWidget);
    expect(find.text('Rendang'), findsNothing);

    await tester.enterText(find.byKey(const ValueKey('food-search')), '');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('favorite-rendang')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('nav-profile')));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Ayu 👋'), findsNothing);
    expect(find.text('Rendang'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('journal validates and saves notes with selected food', (
    tester,
  ) async {
    await _openHome(tester);

    await tester.tap(find.byKey(const ValueKey('nav-journal')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('save-journal-entry')));
    await tester.pumpAndSettle();

    expect(find.text('Catatan belum boleh kosong.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('journal-note')),
      'Kuah rempahnya mengingatkan pada masakan rumah.',
    );
    await tester.tap(find.byKey(const ValueKey('save-journal-entry')));
    await tester.pumpAndSettle();

    expect(find.text('Catatan rasa berhasil disimpan!'), findsOneWidget);
    expect(
      find.text('Kuah rempahnya mengingatkan pada masakan rumah.'),
      findsOneWidget,
    );
    expect(find.text('2 catatan rasa'), findsOneWidget);
  });

  testWidgets('food details can send a menu straight to the journal', (
    tester,
  ) async {
    await _openHome(tester);

    await tester.tap(find.byKey(const ValueKey('home-hero')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sate Lilit'));
    await tester.pumpAndSettle();

    expect(find.text('Cerita di balik rasa'), findsOneWidget);
    final journalButton = find.byKey(
      const ValueKey('detail-add-to-journal'),
    );
    await tester.ensureVisible(journalButton);
    await tester.tap(journalButton);
    await tester.pumpAndSettle();

    expect(find.text('Jurnal rasa'), findsOneWidget);
    expect(find.text('Catatan baru'), findsOneWidget);
  });

  testWidgets('journal draft and filters survive tabs and screen rotation', (
    tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await _openHome(tester);

    await tester.tap(find.byKey(const ValueKey('nav-explore')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('category-Camilan')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('nav-journal')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('journal-note')),
      'Disimpan dulu untuk dicatat nanti.',
    );
    await tester.pumpAndSettle();

    await tester.binding.setSurfaceSize(const Size(800, 420));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('nav-explore')));
    await tester.pumpAndSettle();

    expect(
      tester.widget<ChoiceChip>(
        find.byKey(const ValueKey('category-Camilan')),
      ).selected,
      isTrue,
    );

    await tester.tap(find.byKey(const ValueKey('nav-journal')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextFormField>(find.byKey(const ValueKey('journal-note')))
          .controller
          ?.text,
      'Disimpan dulu untuk dicatat nanti.',
    );
  });
}
