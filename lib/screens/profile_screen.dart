import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../widgets/screen_components.dart';

const _forest = Color(0xff19564c);
const _muted = Color(0xff7c8078);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _forest,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 29,
                  backgroundColor: Colors.white.withValues(alpha: .17),
                  child: Text(
                    state.userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Penjelajah rasa lokal',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .77),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('🧭', style: TextStyle(fontSize: 27)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _ProfileStat(
                  value: '${state.favoriteCount}',
                  label: 'Favorit',
                  icon: Icons.favorite_outline_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ProfileStat(
                  value: '${state.entries.length}',
                  label: 'Catatan',
                  icon: Icons.menu_book_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ProfileStat(
                  value: '${state.foods.length}',
                  label: 'Kuliner',
                  icon: Icons.restaurant_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const SectionHeading(
            title: 'Rasa favoritmu',
            subtitle: 'Menu yang ingin kamu ingat',
          ),
          const SizedBox(height: 12),
          if (state.favoriteFoods.isEmpty)
            const EmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'Belum ada favorit',
              message: 'Tekan ikon hati pada kuliner yang kamu suka.',
            )
          else
            for (final food in state.favoriteFoods)
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: FoodCard(food: food),
              ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            key: const ValueKey('logout-button'),
            onPressed: () =>
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (_) => false),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Keluar dari sesi'),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'JejakRasa · Cerita di balik setiap suapan',
              style: TextStyle(color: _muted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withValues(alpha: .05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: _forest, size: 19),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
          Text(label, style: const TextStyle(color: _muted, fontSize: 10)),
        ],
      ),
    );
  }
}
