import 'package:flutter/foundation.dart';

import 'models.dart';

class AppState extends ChangeNotifier {
  final Set<String> _favorites = {'sate-lilit'};
  final List<JournalEntry> _entries = [
    JournalEntry(
      foodId: 'sate-lilit',
      note: 'Rasa serai bakarnya enak sekali; wajib cari lagi kalau ke Bali.',
      createdAt: DateTime(2026, 10, 12),
    ),
  ];

  String _category = foodCategories.first;
  String _searchQuery = '';
  String _loginName = '';
  String _userName = 'Sahabat Rasa';
  String _journalDraft = '';
  String _journalFoodId = sampleFoods.first.id;
  int _selectedTab = 0;

  List<Food> get foods => sampleFoods;
  List<JournalEntry> get entries => List.unmodifiable(_entries);
  String get category => _category;
  String get searchQuery => _searchQuery;
  String get loginName => _loginName;
  String get userName => _userName;
  String get journalDraft => _journalDraft;
  String get journalFoodId => _journalFoodId;
  int get selectedTab => _selectedTab;
  int get favoriteCount => _favorites.length;

  List<Food> get favoriteFoods =>
      foods.where((food) => _favorites.contains(food.id)).toList();

  List<Food> get filteredFoods {
    final query = _searchQuery.trim().toLowerCase();
    return foods.where((food) {
      final matchesCategory =
          _category == foodCategories.first || food.category == _category;
      final matchesQuery =
          query.isEmpty ||
          '${food.name} ${food.region} ${food.category}'.toLowerCase().contains(
            query,
          );
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Food? foodById(String id) {
    for (final food in foods) {
      if (food.id == id) return food;
    }
    return null;
  }

  Food? foodForEntry(JournalEntry entry) => foodById(entry.foodId);

  bool isFavorite(String foodId) => _favorites.contains(foodId);

  void toggleFavorite(String foodId) {
    if (!_favorites.add(foodId)) {
      _favorites.remove(foodId);
    }
    notifyListeners();
  }

  void setCategory(String category) {
    if (!foodCategories.contains(category) || _category == category) return;
    _category = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void updateLoginName(String name) {
    if (_loginName == name) return;
    _loginName = name;
    notifyListeners();
  }

  void signIn() {
    final name = _loginName.trim();
    if (name.length < 2) return;
    _userName = name;
    notifyListeners();
  }

  void selectTab(int index) {
    if (index < 0 || index > 3 || _selectedTab == index) return;
    _selectedTab = index;
    notifyListeners();
  }

  void updateJournalDraft(String draft) {
    _journalDraft = draft;
    notifyListeners();
  }

  void selectJournalFood(String foodId) {
    if (foodById(foodId) == null || _journalFoodId == foodId) return;
    _journalFoodId = foodId;
    notifyListeners();
  }

  bool addJournalEntry() {
    final note = _journalDraft.trim();
    if (note.isEmpty || foodById(_journalFoodId) == null) return false;
    _entries.insert(
      0,
      JournalEntry(
        foodId: _journalFoodId,
        note: note,
        createdAt: DateTime.now(),
      ),
    );
    _journalDraft = '';
    notifyListeners();
    return true;
  }
}
