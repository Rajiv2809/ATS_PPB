import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../models.dart';

const _forest = Color(0xff19564c);
const _muted = Color(0xff7c8078);

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (subtitle case final value?) ...[
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(color: _muted, fontSize: 12),
                ),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class CategoryFilters extends StatelessWidget {
  const CategoryFilters({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final category in foodCategories) ...[
            ChoiceChip(
              key: ValueKey('category-$category'),
              label: Text(category),
              selected: selected == category,
              showCheckmark: false,
              onSelected: (_) => onSelected(category),
              labelStyle: TextStyle(
                color: selected == category ? Colors.white : _muted,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              selectedColor: _forest,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: selected == category
                    ? _forest
                    : Colors.black.withValues(alpha: .07),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            if (category != foodCategories.last) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final favorite = state.isFavorite(food.id);

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
        side: BorderSide(color: Colors.black.withValues(alpha: .05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            Navigator.of(context).pushNamed('/detail', arguments: food.id),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              FoodCover(food: food, height: 90, width: 90),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${food.region}  ·  ${food.category}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 15,
                          color: Color(0xffffb74d),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          food.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            food.price,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: _muted, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                key: ValueKey('favorite-${food.id}'),
                tooltip: favorite ? 'Hapus dari favorit' : 'Simpan ke favorit',
                onPressed: () => state.toggleFavorite(food.id),
                icon: Icon(
                  favorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: favorite ? Colors.redAccent : _muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCover extends StatelessWidget {
  const FoodCover({
    super.key,
    required this.food,
    this.height = 190,
    this.width,
  });

  final Food food;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: food.color,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [food.color, food.color.withValues(alpha: .68)],
        ),
      ),
      child: Center(
        child: Text(food.emoji, style: TextStyle(fontSize: height * .47)),
      ),
    );
  }
}

class JournalEntryCard extends StatelessWidget {
  const JournalEntryCard({super.key, required this.entry, required this.food});

  final JournalEntry entry;
  final Food? food;

  @override
  Widget build(BuildContext context) {
    final date = entry.createdAt.toLocal();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withValues(alpha: .05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoodCover(
            food:
                food ??
                const Food(
                  id: 'unknown',
                  name: 'Catatan rasa',
                  region: 'Nusantara',
                  category: 'Kuliner',
                  emoji: '🍽️',
                  price: '',
                  rating: 0,
                  description: '',
                  story: '',
                  coverColor: 0xffe6c6a7,
                ),
            width: 49,
            height: 49,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food?.name ?? 'Catatan rasa',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  entry.note,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
      child: Column(
        children: [
          Icon(icon, size: 34, color: _muted),
          const SizedBox(height: 9),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _muted, fontSize: 12, height: 1.5),
          ),
          ?action,
        ],
      ),
    );
  }
}
