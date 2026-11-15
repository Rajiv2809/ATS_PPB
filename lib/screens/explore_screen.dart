import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../models.dart';
import '../widgets/screen_components.dart';

const _muted = Color(0xff7c8078);

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final foods = state.filteredFoods;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelajah rasa'),
        actions: [
          IconButton(
            tooltip: 'Bersihkan pencarian',
            onPressed: state.searchQuery.isEmpty
                ? null
                : () => state.setSearchQuery(''),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          const Text(
            'Cari santapan atau daerah asalnya.',
            style: TextStyle(color: _muted, fontSize: 14),
          ),
          const SizedBox(height: 18),
          TextFormField(
            key: const ValueKey('food-search'),
            initialValue: state.searchQuery,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Contoh: serabi, Bali...',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: state.setSearchQuery,
          ),
          const SizedBox(height: 20),
          CategoryFilters(
            selected: state.category,
            onSelected: state.setCategory,
          ),
          const SizedBox(height: 22),
          SectionHeading(
            title: 'Temuan untukmu',
            subtitle: '${foods.length} menu ditemukan',
          ),
          const SizedBox(height: 13),
          if (foods.isEmpty)
            EmptyState(
              icon: Icons.restaurant_menu_rounded,
              title: 'Belum ada hasil',
              message: 'Coba kata kunci atau kategori lainnya.',
              action: TextButton(
                onPressed: () {
                  state.setSearchQuery('');
                  state.setCategory(foodCategories.first);
                },
                child: const Text('Tampilkan semua menu'),
              ),
            )
          else
            for (final food in foods)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FoodCard(food: food),
              ),
        ],
      ),
    );
  }
}
