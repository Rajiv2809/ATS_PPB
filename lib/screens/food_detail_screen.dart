import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../models.dart';
import '../widgets/screen_components.dart';

const _muted = Color(0xff7c8078);

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerita kuliner'),
        actions: [
          IconButton(
            key: ValueKey('favorite-${food.id}'),
            tooltip: state.isFavorite(food.id)
                ? 'Hapus dari favorit'
                : 'Simpan ke favorit',
            onPressed: () => state.toggleFavorite(food.id),
            icon: Icon(
              state.isFavorite(food.id)
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: state.isFavorite(food.id) ? Colors.redAccent : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodCover(food: food, height: 224),
            const SizedBox(height: 22),
            Text(
              '${food.region.toUpperCase()}  ·  ${food.category.toUpperCase()}',
              style: const TextStyle(
                color: _muted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              food.name,
              style: const TextStyle(
                fontSize: 30,
                height: 1.1,
                fontWeight: FontWeight.w800,
                letterSpacing: -.6,
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xffffb74d)),
                const SizedBox(width: 4),
                Text(
                  '${food.rating.toStringAsFixed(1)}  ·  ${food.price}',
                  style: const TextStyle(
                    color: _muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21),
            Text(
              food.description,
              style: const TextStyle(fontSize: 15, height: 1.65),
            ),
            const SizedBox(height: 23),
            const SectionHeading(title: 'Cerita di balik rasa'),
            const SizedBox(height: 8),
            Text(
              food.story,
              style: const TextStyle(color: _muted, fontSize: 14, height: 1.7),
            ),
            const SizedBox(height: 27),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                key: const ValueKey('detail-add-to-journal'),
                onPressed: () {
                  state.selectJournalFood(food.id);
                  state.selectTab(2);
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == '/app');
                },
                icon: const Icon(Icons.edit_note_rounded),
                label: const Text('Catat rasa ini di jurnal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
