import 'package:flutter_test/flutter_test.dart';
import 'package:jejak_rasa/app_state.dart';
import 'package:jejak_rasa/models.dart';

void main() {
  group('AppState', () {
    late AppState state;

    setUp(() {
      state = AppState();
    });

    tearDown(() {
      state.dispose();
    });

    test('search and category filters work together', () {
      state.setSearchQuery('semarang');
      expect(
        state.filteredFoods.map((food) => food.id),
        <String>['lumpia'],
      );

      state.setCategory('Minuman');
      expect(state.filteredFoods, isEmpty);

      state.setSearchQuery('');
      expect(
        state.filteredFoods.map((food) => food.id),
        <String>['es-dawet'],
      );
    });

    test('favorites can be added and removed', () {
      expect(state.favoriteCount, 1);
      expect(state.isFavorite('rendang'), isFalse);

      state.toggleFavorite('rendang');
      expect(state.isFavorite('rendang'), isTrue);
      expect(state.favoriteCount, 2);

      state.toggleFavorite('rendang');
      expect(state.isFavorite('rendang'), isFalse);
      expect(state.favoriteCount, 1);
    });

    test('journal rejects empty notes and saves trimmed notes', () {
      state.updateJournalDraft('   ');
      expect(state.addJournalEntry(), isFalse);
      expect(state.entries, hasLength(1));

      state.selectJournalFood('lumpia');
      state.updateJournalDraft('  Renyah dan hangat.  ');
      expect(state.addJournalEntry(), isTrue);
      expect(state.entries, hasLength(2));
      expect(state.entries.first.foodId, 'lumpia');
      expect(state.entries.first.note, 'Renyah dan hangat.');
      expect(state.journalDraft, isEmpty);
    });

    test('shared state retains selections and drafts between screens', () {
      state.setCategory('Camilan');
      state.toggleFavorite('rendang');
      state.selectTab(2);
      state.updateJournalDraft('Suasananya ramai dan menyenangkan.');

      expect(state.selectedTab, 2);
      expect(state.category, 'Camilan');
      expect(state.isFavorite('rendang'), isTrue);
      expect(state.journalDraft, 'Suasananya ramai dan menyenangkan.');
      expect(state.foods, hasLength(sampleFoods.length));
    });
  });
}
