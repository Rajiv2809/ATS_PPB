import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../widgets/screen_components.dart';

const _forest = Color(0xff19564c);
const _muted = Color(0xff7c8078);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final popularFoods = state.filteredFoods.take(3).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'KAMIS, 12 NOVEMBER',
                            style: TextStyle(
                              color: _muted,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.4,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Halo, ${state.userName} 👋',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Buka profil',
                      onPressed: () => state.selectTab(3),
                      icon: const Icon(Icons.account_circle_outlined, size: 29),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                _HeroCard(onTap: () => state.selectTab(1)),
                const SizedBox(height: 27),
                const SectionHeading(
                  title: 'Jelajah berdasarkan selera',
                  subtitle: 'Ada apa di meja makanmu hari ini?',
                ),
                const SizedBox(height: 13),
                CategoryFilters(
                  selected: state.category,
                  onSelected: state.setCategory,
                ),
                const SizedBox(height: 28),
                SectionHeading(
                  title: 'Rasa untuk ditemukan',
                  subtitle:
                      '${state.filteredFoods.length} cerita kuliner lokal',
                  trailing: TextButton(
                    onPressed: () => state.selectTab(1),
                    child: const Text('Lihat semua'),
                  ),
                ),
                const SizedBox(height: 9),
                if (popularFoods.isEmpty)
                  const EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'Belum ada yang cocok',
                    message: 'Coba pilih kategori yang berbeda.',
                  )
                else
                  for (final food in popularFoods)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FoodCard(food: food),
                    ),
                if (popularFoods.isNotEmpty &&
                    state.filteredFoods.length > popularFoods.length)
                  Align(
                    child: TextButton.icon(
                      onPressed: () => state.selectTab(1),
                      icon: const Icon(Icons.explore_outlined),
                      label: const Text('Lihat semua kuliner'),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _forest,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: const ValueKey('home-hero'),
        onTap: onTap,
        child: SizedBox(
          height: 190,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                right: -17,
                bottom: -34,
                child: Icon(
                  Icons.spa_rounded,
                  size: 178,
                  color: Colors.white.withValues(alpha: .09),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 21, 20, 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        child: Text(
                          'CERITA RASA NUSANTARA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Setiap rasa punya\ncerita.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -.4,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Text(
                          'Temukan sudut Indonesia lewat kulinernya',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .83),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
