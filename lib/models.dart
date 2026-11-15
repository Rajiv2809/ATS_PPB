import 'package:flutter/material.dart';

@immutable
class Food {
  const Food({
    required this.id,
    required this.name,
    required this.region,
    required this.category,
    required this.emoji,
    required this.price,
    required this.rating,
    required this.description,
    required this.story,
    required this.coverColor,
  });

  final String id;
  final String name;
  final String region;
  final String category;
  final String emoji;
  final String price;
  final double rating;
  final String description;
  final String story;
  final int coverColor;

  Color get color => Color(coverColor);
}

@immutable
class JournalEntry {
  const JournalEntry({
    required this.foodId,
    required this.note,
    required this.createdAt,
  });

  final String foodId;
  final String note;
  final DateTime createdAt;
}

const foodCategories = <String>[
  'Semua',
  'Makanan berat',
  'Camilan',
  'Minuman',
];

const sampleFoods = <Food>[
  Food(
    id: 'sate-lilit',
    name: 'Sate Lilit',
    region: 'Bali',
    category: 'Makanan berat',
    emoji: '🍢',
    price: 'Rp 25 ribu',
    rating: 4.9,
    description:
        'Ikan segar berbumbu basa genep, dililitkan pada batang serai lalu '
        'dibakar perlahan sampai harum.',
    story:
        'Di Bali, sate lilit adalah hidangan kebersamaan. Aroma serai '
        'menyambutmu bahkan sebelum sate pertama mendarat di piring.',
    coverColor: 0xffe6c6a7,
  ),
  Food(
    id: 'rendang',
    name: 'Rendang',
    region: 'Padang',
    category: 'Makanan berat',
    emoji: '🍛',
    price: 'Rp 32 ribu',
    rating: 4.9,
    description:
        'Daging dimasak lama dalam santan dan rempah hingga bumbunya pekat '
        'meresap sampai ke serat.',
    story:
        'Setiap keluarga di Minangkabau punya racikan rendang andalannya '
        'sendiri, diwariskan dengan sabar dari satu generasi ke generasi.',
    coverColor: 0xffdfae85,
  ),
  Food(
    id: 'lumpia',
    name: 'Lumpia Semarang',
    region: 'Semarang',
    category: 'Camilan',
    emoji: '🥟',
    price: 'Rp 18 ribu',
    rating: 4.8,
    description:
        'Kulit lumpia renyah berisi rebung, telur, dan suwiran ayam. Makin '
        'nikmat dicocol saus bawang khas Semarang.',
    story:
        'Lumpia Semarang punya kisah akulturasi yang lezat: resep keluarga '
        'Tionghoa dan Jawa berpadu dalam satu gigitan.',
    coverColor: 0xfff0d7a1,
  ),
  Food(
    id: 'es-dawet',
    name: 'Es Dawet Ayu',
    region: 'Banjarnegara',
    category: 'Minuman',
    emoji: '🥤',
    price: 'Rp 12 ribu',
    rating: 4.7,
    description:
        'Cendol hijau dari tepung beras bertemu santan lembut, gula merah, '
        'dan es serut.',
    story:
        'Nama "ayu" menyertai dawet dari Banjarnegara sebagai pengingat '
        'kecil akan keramahan yang manis dan menyegarkan.',
    coverColor: 0xffb8d5be,
  ),
  Food(
    id: 'seblak',
    name: 'Seblak Bandung',
    region: 'Bandung',
    category: 'Makanan berat',
    emoji: '🍜',
    price: 'Rp 20 ribu',
    rating: 4.8,
    description:
        'Kerupuk kenyal dan topping pilihan berpadu dalam kuah kencur '
        'pedas khas Kota Kembang.',
    story:
        'Seblak selalu punya cara sendiri untuk menghangatkan sore: kuah '
        'pedas, aroma kencur, dan topping sesukamu.',
    coverColor: 0xffedb5a3,
  ),
  Food(
    id: 'serabi',
    name: 'Serabi Solo',
    region: 'Surakarta',
    category: 'Camilan',
    emoji: '🥞',
    price: 'Rp 15 ribu',
    rating: 4.6,
    description:
        'Kue berbahan santan yang dimasak di atas tungku tanah liat, '
        'lembut di tengah dengan pinggiran renyah.',
    story:
        'Dimasak perlahan dengan wajan kecil, serabi menjadi teman sarapan '
        'favorit di sudut-sudut Kota Solo.',
    coverColor: 0xffefcf9b,
  ),
];
